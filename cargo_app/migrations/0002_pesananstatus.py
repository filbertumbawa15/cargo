# Generated by Django 4.2.1 on 2023-05-11 15:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cargo_app', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='PesananStatus',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('trx_id', models.CharField(editable=False, max_length=100)),
                ('tgl_status', models.DateTimeField()),
                ('created_on', models.DateTimeField(auto_now_add=True)),
                ('last_modified', models.DateTimeField(auto_now=True)),
                ('no_bukti', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pesanan_status_pesanan', to='cargo_app.pesanan')),
                ('status', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='status_pesanan_status', to='cargo_app.status')),
                ('user_create', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='user_create_pesanan_status', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
