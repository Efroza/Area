# Generated by Django 4.1.1 on 2022-10-24 13:47

import Service.models
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, unique=True)),
                ('name', models.CharField(max_length=200)),
                ('description', models.CharField(default='', max_length=200)),
                ('image', models.ImageField(blank=True, null=True, upload_to=Service.models.filepath)),
            ],
        ),
    ]
