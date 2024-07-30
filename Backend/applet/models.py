##
# @file models.py
# @brief Ce fichier permet de créer les différents modèles de la base de données.
# @section la class Action :
# - @param models.Model : permet de créer un modèle
# @description Ce modèle permet de créer les différentes actions que l'utilisateur peut faire sur le serveur.
# @section la class Reaction :
# - @param models.Model : permet de créer un modèle
# @description Ce modèle permet de créer les différentes réactions que l'utilisateur peut faire sur le serveur.
# @section la class Applet :
# - @param models.Model : permet de créer un modèle
# @description Ce modèle permet de créer les différents applets que l'utilisateur peut faire sur le serveur.
from enum import unique
from django.db import models

# Create your models here.
class Action(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    name = models.CharField(max_length=200, unique=True)
    description = models.CharField(max_length=200, default='')
    id_service = models.IntegerField(default=0)

    def __str__(self) -> str:
        return 'Action: ' + 'name= ' + self.name + ', id= ' + str(self.id)

class Reaction(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    name = models.CharField(max_length=200, unique=True)
    description = models.CharField(max_length=200, default='')
    id_service = models.IntegerField(default=0)

    def __str__(self) -> str:
        return 'Reaction:' + self.name

class Applet(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    activate = models.BooleanField(default=False)
    description = models.CharField(max_length=200, default='')
    date = models.DateTimeField(auto_now_add=True, blank=True)
    id_user = models.IntegerField(default=0)

    def __str__(self) -> str:
        return 'Applet: id= ' + str(self.id) + 'activate= ' + str(self.activate) + 'description= ' + self.description

class Action_Running(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    id_action = models.IntegerField()
    id_applet = models.IntegerField()
    query_string = models.CharField(max_length=250, default='')
    def __str__(self) -> str:
        return 'Action_Running: id= ' + str(self.id) + ' id_action= ' + str(self.id_action) + ' id_applet= ' + str(self.id_applet)

class Reaction_Running(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    id_reaction = models.IntegerField()
    id_applet = models.IntegerField()
    query_string = models.CharField(max_length=250, default='')
    order = models.IntegerField()

    def __str__(self) -> str:
        return 'Reaction_Running: id= ' + str(self.id) + ' id_reaction= ' + str(self.id_action) + ' id_applet= ' + str(self.id_applet)

class Action_Mandatory(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    id_action = models.IntegerField()
    name = models.CharField(max_length=20)

    def __str__(self) -> str:
        return 'Action_Mandatory: id= ' + self.id + ' id_action= ' + self.id_action + ' name= ' + self.name

class Reaction_Mandatory(models.Model):
    id = models.AutoField(primary_key=True, unique=True)
    id_reaction = models.IntegerField()
    name = models.CharField(max_length=20)

    def __str__(self) -> str:
        return 'Reaction_Mandatory: id= ' + str(self.id) + ' id_reaction= ' + str(self.id_reaction) + ' name= ' + self.name