# Generated by Django 4.2.1 on 2023-05-13 12:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cargo_app', '0007_user_is_customer'),
    ]

    operations = [
        migrations.AlterField(
            model_name='pesananstatus',
            name='tgl_status',
            field=models.DateTimeField(auto_now=True),
        ),
    ]