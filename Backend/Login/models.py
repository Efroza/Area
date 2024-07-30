##
# @file models.py
# @brief Ce fichier permet de setUp la class User de Django, qui sera donc utilisé dans la database.
# @section Les différents attributs :
#   - username : le nom d'utilisateur.
#   - email : l'email de l'utilisateur.
#   - password : le mot de passe de l'utilisateur.
#   - first_name : le prénom de l'utilisateur.
#   - last_name : le nom de l'utilisateur.
#   - id : l'id de l'utilisateur.
#   - Token : le token de l'utilisateur.
#   - IsVerified : permet de savoir si l'utilisateur a vérifié son email.
#   - Image : l'image de l'utilisateur.

from django.db import models

# Create your models here.
class User(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    IsVerified = models.BooleanField(default=False)
    FirstName = models.CharField(max_length=50)
    LastName = models.CharField(max_length=50)
    Email = models.EmailField(max_length=50)
    Password = models.CharField(max_length=50)
    Token = models.CharField(max_length=50)
    Image = models.ImageField(upload_to='', blank=True)

    class Meta:
        db_table = 'user_register'