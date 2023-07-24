from rest_framework import serializers
from cargo_app.models import (Biaya, BiayaJarak, Pesanan, Profile, User, PesananStatus, PaymentStatus, Status)
from django.core.exceptions import ValidationError
from rest_framework.validators import UniqueValidator
from django.contrib.auth import authenticate
from rest_framework import exceptions
from django.contrib.auth.password_validation import validate_password

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username', '')
        password = data.get('password', '')

        if username and password:
            user = authenticate(username = username , password = password)
            
            if user:
                if user.is_active and user.is_customer:
                    data["user"] = user
                else:
                    msg = "User is deactivated..."
                    raise exceptions.ValidationError(msg)
            else:
                msg = "Unable to login with given credentials..."
                raise exceptions.ValidationError(msg)
        else:
            msg = "Must provide username and password both..."
            raise exceptions.ValidationError(msg)
        return data
    
class ProfileSerializer(serializers.ModelSerializer):
    # user_detail = RegisterUserSerializer(read_only=True, many=True)
    email = serializers.CharField(source='user.email')
    name = serializers.CharField(source='user.first_name')
    username = serializers.CharField(source='user.username')
    class Meta:
        model = Profile
        fields = ('id', 'email', 'name', 'username', 'avatar', 'bio', 'status')

class RegisterUserSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required = True, validators = [UniqueValidator(queryset=User.objects.all())])
    password1 = serializers.CharField(write_only=True, required = True, validators = [validate_password])
    password2 = serializers.CharField(write_only=True, required = True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2', 'is_active', 'is_customer', 'first_name', 'last_name']
        extra_kwargs = {
            'first_name' : {'required' : True},
            'last_name ': {'required' : True}
        }

    def validate(self, attrs):
        if attrs["password1"] != attrs["password2"]:
            raise serializers.ValidationError({
                'password' : "Password field did not match..."
            })
        return attrs
    
    def create(self, validated_data):
        user = User.objects.create(
            username = validated_data["username"],
            email = validated_data["email"],
            is_active = validated_data["is_active"],
            is_customer= validated_data["is_customer"],
            first_name = validated_data["first_name"],
            last_name = validated_data["last_name"]
        )
        user.set_password(validated_data['password1'])
        user.save()
        profile = Profile.objects.create(user = user)
        profile.save()
        return user

class BiayaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Biaya
        fields = ('id', 'name', 'nominal', 'status')

class BiayaJarakSerializer(serializers.ModelSerializer):
    class Meta:
        model = BiayaJarak
        fields = ('id', 'status_layanan', 'batas_awal', 'batas_akhir', 'nominal', 'keterangan', 'status')

class PesananSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pesanan
        fields = ('id','no_bukti','trx_id','payment_code', 'jarak', 'waktu', 'namapengirim', 'notelppengirim', 'alamatdetailpengirim', 'placeidlokasiasal','latitude_lokasi_asal', 'longitude_lokasi_asal', 'kelurahan_lokasi_asal', 'note_pengirim', 'namapenerima', 'notelppenerima', 'alamatdetailpenerima', 'placeidlokasitujuan', 'latitude_lokasi_tujuan', 'longitude_lokasi_tujuan', 'kelurahan_lokasi_tujuan', 'note_penerima', 'harga', 'type_cargo', 'payment_status', 'category', 'keterangan', 'is_check_term_conditions', 'user_id')

class PesananStatusSerializer(serializers.ModelSerializer):
    status_kode = serializers.SerializerMethodField()
    
    def get_status_kode(self, obj):
        return {'name': obj.status.kodestatus}

    class Meta:
        model = PesananStatus
        fields = ('no_bukti', 'trx_id', 'status', 'tgl_status', 'status_kode')

class PaymentStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentStatus
        fields = ('code', 'name')

class StatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Status
        fields = ('kodestatus', 'keterangan')