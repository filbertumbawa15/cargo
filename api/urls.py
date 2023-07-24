from django.urls import path, include
from api import views
from rest_framework.urlpatterns import format_suffix_patterns

app_name = 'api'
urlpatterns = [
    path('api/v1/login', views.LoginView.as_view()),
    path('api/v1/logout', views.LogoutView.as_view()),
    path('api/v1/register', views.RegisterUserApi.as_view()),
    path('api/pesanan', views.PesananListApiView.as_view()),
    path('api/pesanan/<str:no_bukti>', views.PesananDetailApiView.as_view()),
    path('api/v1/profile/<int:user_id>', views.ProfileDetailAPI.as_view()),
    path('api/cekongkoskirim', views.cekongkoskirim),
    path('api/listPesanan', views.listPesanan),
    path('api/profile/<int:user_id>', views.ProfileDetailAPI.as_view()),
    path('api/paymentNotification', views.paymentNotification),
    path('api/pesananstatus', views.PesananStatusListApiView.as_view()),
    path('api/pesananstatus/<str:no_bukti>', views.PesananStatusDetailApiView.as_view()),
]   