# Generated by Django 4.2.1 on 2023-07-03 03:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cargo_app', '0013_remove_pesanan_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='pesanan',
            name='category',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
