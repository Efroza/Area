##
# @file forms.py
# @brief Ce fichier permet de setUp le form de la création du user sur le serveur
# @section la class UserForm : 
# - @param forms.ModelForm : permet de créer un form
# - class Meta : permet de setUp les différents attributs du form
# - function clean_email : permet de vérifier si l'email est correct
from django import forms
from .models import User

class UserForm(forms.ModelForm):
    ## @brief Ce fichier permet de setUp le form de la création du user sur le serveur
    class Meta:
        model = User
        fields = ['FirstName', 'LastName', 'Email', 'Password']

    def clean_email(self):
        mail = self.cleaned_data.get('Email')
        if not '@' in mail:
            raise forms.ValidationError('Invalid email')
        # elif
        return mail