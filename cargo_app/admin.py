from django.contrib import admin
from cargo_app.models import (User, Category, Profile, Biaya, BiayaJarak, PaymentStatus, Pesanan, Status, PesananStatus)

admin.site.register(Category)
admin.site.register(User)
admin.site.register(Profile)
admin.site.register(Biaya)
admin.site.register(BiayaJarak)
admin.site.register(PaymentStatus)
admin.site.register(Pesanan)
admin.site.register(Status)
admin.site.register(PesananStatus)