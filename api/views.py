from rest_framework.views import APIView
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from rest_framework import status, permissions
from cargo_app.models import (Biaya, BiayaJarak, Pesanan, User, Profile, PaymentStatus, PesananStatus, Status)
from api.serializers import (BiayaSerializer, BiayaJarakSerializer, PesananSerializer, LoginSerializer, RegisterUserSerializer, ProfileSerializer, PaymentStatusSerializer, PesananStatusSerializer, StatusSerializer)
from django.http import HttpResponse, JsonResponse
import json
from decimal import Decimal
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.authtoken.models import Token
from django.contrib.auth import login as django_login, logout as django_logout
from rest_framework import generics
from django.views.decorators.csrf import csrf_protect
from django.middleware.csrf import get_token
import requests
from django.views.decorators.csrf import requires_csrf_token
from django.views.decorators.csrf import csrf_exempt


def cekongkoskirim(request):
    # permission_classes = [IsAuthenticated]
    datajson = json.loads(request.GET.get('data'))
    if request.method == 'GET':
        response = requests.get('https://maps.googleapis.com/maps/api/directions/json?origin='+datajson["alamatdetailpengirim"]+'&destination='+datajson["alamatdetailpenerima"]+'&key=AIzaSyDBc9RaIaig6eEiiCKpEf1qYKpEyyKgpe4')
        directions_jarak = response.json()
        jarak = directions_jarak['routes'][0]['legs'][0]['distance']['value']
        biaya_jarak = BiayaJarak.objects.filter(batas_akhir__gte=jarak, batas_awal__lte=jarak)
        serializer = BiayaJarakSerializer(biaya_jarak, many=True)
        i=0
        while i < len(serializer.data):
            biaya_berat_barang = Biaya.objects.filter(name='Biaya Berat').values('nominal')[0]['nominal'] * datajson['berat_barang']
            biaya_asuransi = Biaya.objects.filter(name='Asuransi Barang').values('nominal')[0]['nominal']
            biaya_berkas = Biaya.objects.filter(name='Biaya Berkas & Lain-lain').values('nominal')[0]['nominal']
            biaya_ppn = Biaya.objects.filter(name='Biaya PPn').values('nominal')[0]['nominal'] * Decimal(serializer.data[i]['nominal'])
            total_modal = Decimal(serializer.data[i]['nominal']) + biaya_berat_barang + biaya_asuransi + biaya_berkas + biaya_ppn
            serializer.data[i]['nominal'] = float(total_modal)
            serializer.data[i]["jarak"] = jarak
            i += 1
        return JsonResponse(serializer.data, safe=False)


#This function to get first row in the detail data, and assign to the dict data by looping in the list data dict
def listPesanan(request):
    datajson = json.loads(request.GET.get('data'))
    dataList = Pesanan.objects.filter(user_id=datajson['user_id'], payment_status=datajson['payment_status'])
    serializer = PesananSerializer(dataList, many=True)
    serializer_data = serializer.data
    i = 0
    while i < len(serializer_data):
        pesananStatus = PesananStatus.objects.filter(no_bukti=serializer_data[i]['id']).order_by('-tgl_status')[:1]
        if not pesananStatus:
            serializer_data[i]["pesanan_status"] = ""
            i+=1
        else:
            serializer_pesananStatus = PesananStatusSerializer(pesananStatus, many=True)
            status = Status.objects.filter(id=serializer_pesananStatus.data[0]['status'])
            serializer_status = StatusSerializer(status, many=True)
            serializer_data[i]["pesanan_status"] = serializer_status.data[0]['kodestatus']
            i+=1
    return JsonResponse(serializer_data, safe=False)

@csrf_exempt
def paymentNotification(request):
    if request.method == "POST":
        dataPesanan = Pesanan.objects.filter(bill_no = request.POST.get('bill_no'))
        datajson = dataPesanan.update(payment_status=2)
        if datajson:
            serializer_pesanan = PesananSerializer(dataPesanan, many=True)
            # dd(serializer_pesanan.data[0])
            data = {
                'no_bukti' : serializer_pesanan.data[0]['id'],
                # 'trx_id' : serializer_pesanan.data[0]['trx_id'],
                'status': 1,
            }
            serializer = PesananStatusSerializer(data = data)
            if serializer.is_valid():
                serializer.save()
                response = {
                    'status' : status.HTTP_201_CREATED,
                    'message' : 'Data status created and payment updated successfully...',
                    'data' : serializer_pesanan.data
                }
                return JsonResponse(response, status = status.HTTP_201_CREATED)
            return JsonResponse(serializer.errors, status = status.HTTP_400_BAD_REQUEST)
            # return JsonResponse({
            #     'response': "Data pemesanan berhasil dibayarkan",
            #     'status': status.HTTP_201_CREATED,
            # }, status=status.HTTP_200_OK)

class PesananListApiView(APIView):
    # permission_classes = [IsAuthenticated]
    def post(self, request, *args, **kwargs):
        datajson = json.loads(request.data.get('data'))
        response_asal = requests.get('https://maps.googleapis.com/maps/api/place/details/json?placeid='+datajson['placeidlokasiasal']+'&key=AIzaSyDBc9RaIaig6eEiiCKpEf1qYKpEyyKgpe4&region=ID')
        result_asal = response_asal.json()
        latitude_asal = result_asal['result']['geometry']['location']['lat']
        longitude_asal = result_asal['result']['geometry']['location']['lng']
        kel_asal = result_asal['result']['address_components'][0]['long_name']
        response_tujuan = requests.get('https://maps.googleapis.com/maps/api/place/details/json?placeid='+datajson['placeidlokasitujuan']+'&key=AIzaSyDBc9RaIaig6eEiiCKpEf1qYKpEyyKgpe4&region=ID')
        result_tujuan = response_tujuan.json()
        latitude_tujuan = result_tujuan['result']['geometry']['location']['lat']
        longitude_tujuan = result_tujuan['result']['geometry']['location']['lng']
        kel_tujuan = result_tujuan['result']['address_components'][0]['long_name']
        data = {
            'payment_code' : datajson["payment_code"],
            'jarak' : datajson["jarak"],
            'waktu' : datajson["waktu"],
            'namapengirim' : datajson["namapengirim"],
            'notelppengirim' : datajson["notelppengirim"],
            'alamatdetailpengirim' : datajson["alamatdetailpengirim"],
            'placeidlokasiasal' : datajson["placeidlokasiasal"],
            'latitude_lokasi_asal' : latitude_asal,
            'longitude_lokasi_asal' : longitude_asal,
            'kelurahan_lokasi_asal' : kel_asal,
            'note_pengirim' : datajson["note_pengirim"],
            'namapenerima' : datajson["namapenerima"],
            'notelppenerima' : datajson["notelppenerima"],
            'alamatdetailpenerima' : datajson["alamatdetailpenerima"],
            'placeidlokasitujuan' : datajson["placeidlokasitujuan"],
            'latitude_lokasi_tujuan' : latitude_tujuan,
            'longitude_lokasi_tujuan' : longitude_tujuan,
            'kelurahan_lokasi_tujuan' : kel_tujuan,
            'note_penerima' : datajson["note_penerima"],
            'harga' : datajson["harga"],
            'type_cargo' : datajson["type_cargo"],
            'payment_status' : "0",
            'category' : datajson["category"],
            'keterangan' : datajson["keterangan"],
            'is_check_term_conditions' : datajson["is_check_term_conditions"],
            'user_id': datajson["user_id"],
        }
        serializer = PesananSerializer(data = data)
        if serializer.is_valid():
            serializer.save()
            response = {
                'status' : status.HTTP_201_CREATED,
                'message' : 'Data transaction added successfully...',
                'data' : serializer.data
            }
            return Response(response, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_400_BAD_REQUEST)

class PesananDetailApiView(APIView):
    permission_classes = [IsAuthenticated]
    def get_object(self, no_bukti):
        try:
            return Pesanan.objects.filter(no_bukti=no_bukti)
        except Pesanan.DoesNotExist:
            return None

    def get(self, request, no_bukti, *args, **kwargs):
        pesanan_instance = self.get_object(no_bukti)
        if not pesanan_instance:
            return Response(
                {
                    'status': status.HTTP_400_BAD_REQUEST,
                    'message': 'Data pesanan does not exist...',
                    'data': {},
                }, status=status.HTTP_400_BAD_REQUEST
            )
        serializer = PesananSerializer(pesanan_instance, many=True)
        response = {
            'status': status.HTTP_200_OK,
            'message': 'Data retrieve successfully',
            'data': serializer.data,
        }
        return Response(response, status=status.HTTP_200_OK)

class LoginView(GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        django_login(request, user)
        token, created = Token.objects.get_or_create(user = user)
        return JsonResponse({
            'data' : {
                'token' : token.key,
                'id' : user.id,
                'username' : user.username,
                'first_name' : user.first_name,
                'last_name' : user.last_name,
                'email' : user.email,
                'is_active' : user.is_active,
                # 'is_superuser' : user.is_superuser,
                'is_customer' : user.is_customer,
            }, 
            'status' : 200,
            'message' : "You're login right now..."
        })
    
class LogoutView(APIView):
    authentication_classes = (TokenAuthentication, )

    def post(self, request):
        django_logout(request)
        # return Response(status=204)
        return JsonResponse({'message': "You have been logout..."})

class RegisterUserApi(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterUserSerializer

#Start Controller Profile
class ProfileDetailAPI(APIView):
    def get_object(self, user_id):
        try:
            return Profile.objects.get(user = user_id)
        except Profile.DoesNotExist:
            return None
        
    def get(self, request, user_id, *args, **kwargs):
        profile_instance = self.get_object(user_id)
        if not profile_instance:
            return Response(
                {'response': "Data does not exists..."},
                status = status.HTTP_400_BAD_REQUEST
            )
        
        serializer = ProfileSerializer(profile_instance)
        return Response(serializer.data, status = status.HTTP_200_OK)
# End Controller Profile

class PesananStatusListApiView(APIView):

    def post(self, request, *args, **kwargs):
        datajson = json.loads(request.POST.get('data'))
        dataPesanan = Pesanan.objects.filter(no_bukti= datajson['no_bukti'])
        serializer_pesanan = PesananSerializer(dataPesanan, many=True)
        data = {
            'no_bukti': serializer_pesanan.data[0]['id'],
            'status': datajson['status'],
        }
        validate_status_pesanan = PesananStatus.objects.filter(no_bukti=serializer_pesanan.data[0]['id'], status=datajson['status'])
        if validate_status_pesanan.exists():
            response = {
                'status' : status.HTTP_201_CREATED,
                'message' : 'Status for this order already added..',
                'data' : {}
            }
            return JsonResponse(response, status = status.HTTP_201_CREATED)
        serializer = PesananStatusSerializer(data = data)
        if serializer.is_valid():
            serializer.save()
            response = {
                'status' : status.HTTP_201_CREATED,
                'message' : 'Status successfully added...',
                'data' : serializer.data
            }
            return JsonResponse(response, status = status.HTTP_201_CREATED)
        return JsonResponse(serializer.errors, status = status.HTTP_400_BAD_REQUEST)

class PesananStatusDetailApiView(APIView):
    
    def get_object(self, no_bukti):
        try:
            return Pesanan.objects.filter(no_bukti=no_bukti)
        except Pesanan.DoesNotExist:
            return None
    
    def get(self, request, no_bukti, *args, **kwargs):
        pesanan_status_instance = self.get_object(no_bukti)
        if not pesanan_status_instance:
            return Response(
                {
                    'status': status.HTTP_400_BAD_REQUEST,
                    'message': 'Data pesanan status does not exist...',
                    'data': {},
                }, status=status.HTTP_400_BAD_REQUEST
            )
        serializer_pesanan = PesananSerializer(pesanan_status_instance, many=True)

        data_pesanan = PesananStatus.objects.filter(no_bukti=serializer_pesanan.data[0]['id'])

        serializer = PesananStatusSerializer(data_pesanan, many=True)
        response = {
            'status': status.HTTP_200_OK,
            'message': 'Data retrieve successfully',
            'data': serializer.data,
        }
        return Response(response, status=status.HTTP_200_OK)