# Generated by Django 4.1.1 on 2022-10-24 16:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('applet', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='action',
            name='id_service',
            field=models.ImageField(default=0, upload_to=''),
        ),
        migrations.AddField(
            model_name='reaction',
            name='id_service',
            field=models.ImageField(default=0, upload_to=''),
        ),
    ]
