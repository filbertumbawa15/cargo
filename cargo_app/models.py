from django.db import models
from django.contrib.auth.models import AbstractUser
from PIL import Image
from datetime import datetime
from datetime import timedelta


def create_running_number():
    last_running = Pesanan.objects.all().order_by('id').last()
    if not last_running:
        return str(datetime.now().strftime('%y'))+'.'+str(datetime.now().strftime('%m'))+'.'+'0000001'
    else:
        no_bukti = last_running.no_bukti
        no_bukti_year,no_bukti_month,no_bukti_running = no_bukti.split('.')
        
        if((no_bukti_year == str(datetime.now().strftime('%y'))) & (no_bukti_month == str(datetime.now().strftime('%m')))):
            no_bukti_run = int(no_bukti_running[0:7])
            no_bukti_int = no_bukti_run + 1
            return str(datetime.now().strftime('%y'))+'.'+str(datetime.now().strftime('%m'))+'.'+str(no_bukti_int).zfill(7)
        elif((no_bukti_year != str(datetime.now().strftime('%y'))) | (no_bukti_month != str(datetime.now().strftime('%m')))):
            return str(datetime.now().strftime('%y'))+'.'+str(datetime.now().strftime('%m'))+'.'+'0000001'

def get_bill_expired():
    return datetime.now() + timedelta(minutes=30)

class User(AbstractUser):
    is_customer = models.BooleanField(default=True)
    is_operational = models.BooleanField(default=False)
    is_accounting = models.BooleanField(default=False)
    is_customerservice = models.BooleanField(default=False)

    def __str__(self):
        return str(self.username) + ' ' + str(self.first_name) + ' ' + str(self.last_name)

class Category(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    name = models.CharField(max_length=100)
    status = models.CharField(
        max_length=15, choices=status_choices, default='Aktif')
    user_create = models.ForeignKey(
        User, related_name='user_create_category', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_category', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Profile(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    user = models.OneToOneField(
        User, related_name='user_profile', on_delete=models.PROTECT)
    avatar = models.ImageField(default='default_images/person.jpg',
                               upload_to='profile_images/', blank=True, null=True)
    bio = models.TextField()
    status = models.CharField(
        max_length=15, choices=status_choices, default='Aktif')
    user_create = models.ForeignKey(
        User, related_name='user_create_profile', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_profile', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.user.first_name) + ' ' + str(self.user.last_name)

    def save(self, *args, **kwargs):
        super().save()
        try:
            img = Image.open(self.avatar.path)
            if img.height > 200 or img.width > 200:
                new_img = (200, 200)
                img.thumbnail(new_img)
                img.save(self.avatar.path)
        except:
            pass

class Biaya(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    name = models.CharField(max_length=50)
    nominal = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=15, choices=status_choices, default='Aktif')
    user_create = models.ForeignKey(
        User, related_name='user_create_biaya', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_biaya', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.name) + ' | ' + str(self.nominal)

class BiayaJarak(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    status_layanan = (
        ('Reguler', 'Reguler'),
        ('Tomorrow', 'Tomorrow'),
        ('SameDay', 'SameDay')
    )
    status_layanan = models.CharField(max_length=15, choices=status_layanan, default='Reguler')
    batas_awal  = models.DecimalField(max_digits=10, decimal_places=2)
    batas_akhir = models.DecimalField(max_digits=10, decimal_places=2)
    nominal = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, choices=status_choices, default='Aktif')
    keterangan = models.CharField(max_length=70, default='')
    user_create = models.ForeignKey(
        User, related_name='user_create_biaya_jarak', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_biaya_jarak', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return 'Batas Awal : ' + str(self.batas_awal) + ' | ' + 'Batas Akhir : '+ str(self.batas_akhir) + ' = ' + str(self.nominal) + ' (' + str(self.status_layanan) + ') '
    
class PaymentStatus(models.Model):
    code = models.IntegerField(default=0, unique=True)
    name = models.CharField(max_length=20)
    user_create = models.ForeignKey(
        User, related_name='user_create_payment_status', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_payment_status', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.name)+ ' ('+str(self.code)+') '


class Pesanan(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    no_bukti = models.CharField(max_length=30, default=create_running_number, editable=False)
    trx_id = models.CharField(max_length=80, editable=False, default='5000370200492240')
    tgl = models.DateTimeField(auto_now_add=True)
    merchant_id = models.CharField(max_length=30, editable=False, default='50003')
    bill_no = models.CharField(max_length=30, default=create_running_number)
    bill_expired = models.DateTimeField(default=get_bill_expired)
    payment_code = models.CharField(max_length=5)
    jarak = models.FloatField(default=0, blank=True, null=True)
    waktu = models.CharField(max_length=50)
    # Pengirim
    namapengirim = models.CharField(max_length=100)
    notelppengirim = models.CharField(max_length=13)
    alamatdetailpengirim = models.CharField(max_length=200)
    placeidlokasiasal = models.CharField(max_length=500)
    latitude_lokasi_asal = models.CharField(max_length=100)
    longitude_lokasi_asal = models.CharField(max_length=100)
    kelurahan_lokasi_asal = models.CharField(max_length=100)
    note_pengirim = models.CharField(max_length=500, blank=True, null=True)

    # Penerima
    namapenerima = models.CharField(max_length=100)
    notelppenerima = models.CharField(max_length=13)
    alamatdetailpenerima = models.CharField(max_length=200)
    placeidlokasitujuan = models.CharField(max_length=500)
    latitude_lokasi_tujuan = models.CharField(max_length=100)
    longitude_lokasi_tujuan = models.CharField(max_length=100)
    kelurahan_lokasi_tujuan = models.CharField(max_length=100)
    note_penerima = models.CharField(max_length=500, blank=True, null=True)

    harga = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    type_cargo = models.CharField(max_length=30)
    payment_status = models.ForeignKey(PaymentStatus, to_field='code', related_name='payment_status_pesanan', blank=True, null=True, on_delete=models.SET_NULL)
    # payment_status = models.ForeignKey(PaymentStatus, to_field='code', related_name='payment_status_pesanan', blank=True, null=True, on_delete=models.CASCADE)
    payment_date = models.DateTimeField(null=True, blank=True)
    # category = models.ForeignKey(Category, related_name='category_pesanan', blank=True, null=True, on_delete=models.SET_NULL)
    category = models.CharField(max_length=200, blank=True, null=True)
    keterangan = models.CharField(max_length=500, blank=True, null=True)
    is_check_term_conditions = models.IntegerField(default=0)
    user_id = models.ForeignKey(User, related_name='user_pesanan', blank=True, null=True, on_delete=models.SET_NULL)

    def __str__(self):
        return str(self.no_bukti)

class Status(models.Model):
    status_choices = (
        ('Aktif', 'Aktif'),
        ('Tidak Aktif', 'Tidak Aktif')
    )
    kodestatus = models.CharField(max_length=50, blank=True, null=True)
    keterangan = models.CharField(max_length=100, blank=True, null=True)
    user_create = models.ForeignKey(
        User, related_name='user_create_status', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_status', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return '('+str(self.id)+'.) '+str(self.kodestatus)

class PesananStatus(models.Model):
    no_bukti = models.ForeignKey(Pesanan, related_name='pesanan_status_pesanan', on_delete=models.CASCADE)
    trx_id = models.CharField(max_length=100, editable=False)
    status = models.ForeignKey(Status, related_name='status_pesanan_status', blank=True, null=True, on_delete=models.SET_NULL)
    tgl_status = models.DateTimeField(auto_now=True)
    user_create = models.ForeignKey(
        User, related_name='user_create_pesanan_status', blank=True, null=True, on_delete=models.SET_NULL)
    user_update = models.ForeignKey(
        User, related_name='user_update_pesanan_status', blank=True, null=True, on_delete=models.SET_NULL)
    created_on = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        self.trx_id = self.no_bukti.trx_id
        super().save(*args, **kwargs)

    def __str__(self):
        return str(self.no_bukti) + ' ('+str(self.status.kodestatus)+')'