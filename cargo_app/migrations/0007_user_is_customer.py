# Generated by Django 4.2.1 on 2023-05-12 17:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cargo_app', '0006_alter_paymentstatus_code_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_customer',
            field=models.BooleanField(default=True),
        ),
    ]
