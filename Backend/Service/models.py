from datetime import datetime
from email.policy import default
from django.db import models
import os

def filepath(request, filename):
    old = filename
    timeNow = datetime.now().strftime('%Y%m%d%H:%M:%S')
    filename = "%s%s" % (timeNow, old)
    return os.path.join('assets', filename)

# Create your models here.
class Service(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    name = models.CharField(max_length=200, unique=True)
    description = models.CharField(max_length=200, default='')
    inscription = models.BooleanField(default=False)
    image = models.ImageField(upload_to=filepath, null=True, blank=True)
    oauth2 = models.BooleanField(default=False)

class ServiceAccount(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    id_service = models.IntegerField()
    id_user = models.IntegerField()
    email = models.CharField(max_length=200, default='')
    password = models.CharField(max_length=200, default='')
    token = models.CharField(max_length=200, default='')
    extra = models.CharField(max_length=200, default='')
