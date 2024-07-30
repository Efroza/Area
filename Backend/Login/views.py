
##
# @file views.py
# @brief Ce programme permet de récupérer les différentes informations de l'utilisateur, signIn, signUp, forgetPassword.
# 
# @section verify_register
#   @param auth_token : Token de l'utilisateur
#   Cette fonction permet de vérifier l'email de l'utilisateur, elle est appelée lorsqu'il clique sur le lien de confirmation de son email.
#   @return HttpResponse : Message de succès ou d'erreur
# 
# @section send_email_for_register
#   @param mail : Email de l'utilisateur
#   @param token : Token de l'utilisateur
#   Cette fonction permet d'envoyer un email à l'utilisateur pour qu'il confirme son email.
#   @return EmailMessage : Message d'erreur ou de succès
#
# @section signup
#   @param request : Requête POST ou GET
#   Cette fonction permet de créer un nouvel utilisateur, elle va vérifier si l'email existe déjà ou non, si oui elle va renvoyer un message d'erreur, sinon elle va créer un nouvel utilisateur et lui envoyer un email pour qu'il confirme son email.
#   @return HttpResponse : Message d'erreur ou de succès
#
# @section newPass
#   @param mail : Email de l'utilisateur
#   @param password : Nouveau mot de passe de l'utilisateur
#   Cette fonction permet de confimer le changement de mot de passe de l'utilisateur, elle est appelée lorsqu'il clique sur le lien de confirmation de son nouveau mot de passe.
#   @return HttpResponse : Message d'erreur ou de succès
#
# @section send_email_forget_pass
#   @param mail : Email de l'utilisateur
#   Cette fonction permet d'envoyer un email à l'utilisateur pour qu'il confirme son nouveau mot de passe.
#   @return EmailMessage : Message d'erreur ou de succès
#
# @section forgetPassword
#   @param request : Requête POST ou GET
#   Cette fonction permet de changer le mot de passe de l'utilisateur, elle va vérifier si l'email existe déjà ou non, si oui elle va envoyer un email pour qu'il confirme son nouveau mot de passe, sinon elle va renvoyer un message d'erreur.
#   @return HttpResponse : Message d'erreur ou de succès
#
# @section delete_useless_users
#   Cette fonction permet de supprimer les utilisateurs qui n'ont pas confirmé leur email.
#
# @section signin
#   @param request : Requête POST ou GET
#   Cette fonction permet de connecter l'utilisateur, elle va vérifier si l'email et le mot de passe sont corrects, si oui elle va renvoyer un message de succès, sinon elle va renvoyer un message d'erreur.
#   @return HttpResponse : Message d'erreur ou de succès
##
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.mail import EmailMessage
from django.conf import settings
from .models import User
import uuid
import json

# Create your views here.
def home(request):
    return render(request, 'index.html')

def home_for_user(request, firstName):
    return HttpResponse('Welcome to your home page ' + firstName)

def verify_register(request, auth_token):
    if request.method == 'GET': ## Si le serveur reçoit une requête GET sur la route /confirm/token=...
        profile = User.objects.get(Token=auth_token)
        profile.IsVerified = True
        profile.save() ## On met à jour la valeur de IsVerified à True et on save le profile
        messages.success(request, 'Your account has been verified')
        return HttpResponse('Your email has been verified') ## On renvoie un message de succès
    messages.error(request, 'Something went wrong') ## Sinon on renvoie un message d'erreur
    return HttpResponse('Something went wrong retry')

def send_email_for_register(mail, token):
    subject = 'Finalize your registration'
    message = f'Hello client, to confirm your registration, please click on the link here: http://127.0.0.1:8080/confirm/token={token}'
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [mail]
    return EmailMessage(subject, message, email_from, recipient_list) ## On envoie un mail à l'utilisateur pour qu'il confirme la création de son compte.

def signup(request):
    if request.method == 'POST': ## Si le serveur reçoit une requête POST sur la route /signup
        if request.POST.get('email') and request.POST.get('password') and request.POST.get('first_name') and request.POST.get('last_name'): ## Si les champs email, password, first_name et last_name sont remplis
            use = User()
            use.Email = request.POST.get('email')
            use.Password = request.POST.get('password')
            use.FirstName = request.POST.get('first_name')
            use.LastName = request.POST.get('last_name')
            use.Token = str(uuid.uuid4())
            use.IsVerified = False
            if User.objects.filter(Email=use.Email).exists(): ## Si l'email existe déjà
                return HttpResponse("Email already exists")
            send_email_for_register(use.Email, use.Token).send() ## On envoie un mail à l'utilisateur pour qu'il confirme la création de son compte.
            use.save() ## On sauvegarde l'utilisateur
            messages.success(request, 'User registered successfully')
            return redirect('signin')
        else: ## Si les champs sont envoyés en json.
            data = json.loads(request.body)
            use = User()
            use.FirstName = data['first_name']
            use.LastName = data['last_name']
            use.Email = data['email']
            use.Password = data['password']
            use.Token = str(uuid.uuid4())
            use.IsVerified = False
            if User.objects.filter(Email=use.Email).exists():
                return HttpResponse("Email already exists")
            send_email_for_register(use.Email, use.Token).send()
            use.save()
            messages.success(request, 'User registered successfully')
            return redirect('signin')
    return render(request, 'signup.html')

def newPass(request, mail, password):
    if request.method == 'GET': ## Si le serveur reçoit une requête GET sur la route /newPass/mail=.../password=...
        if User.objects.filter(Email=mail).exists():
            get = User.objects.get(Email=mail)
            get.Password = password
            get.save() ## On met à jour le mot de passe de l'utilisateur et on save le profile
            return HttpResponse('Your password has been changed')
        return HttpResponse('Email does not exist')
    return HttpResponse('Something went wrong retry')

def send_email_forget_pass(mail, password):
    subject = 'Change your password'
    message = f'Hello client, to confirm your new password, please click on the link here: http://127.0.0.1:8080/confirm/email={mail}/newPass={password}'
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [mail]
    return EmailMessage(subject, message, email_from, recipient_list) ## On envoie un mail à l'utilisateur pour qu'il confirme son nouveau mot de passe.

def forgetPassword(request):
    if request.method == 'POST': ## Si le serveur reçoit une requête POST sur la route /forgetPassword
        if request.POST.get('email') and request.POST.get('password'):
            Email = request.POST.get('email')
            Password = request.POST.get('password')

            if User.objects.filter(Email=Email).exists():
                send_email_forget_pass(Email, Password).send() ## On envoie un mail à l'utilisateur pour qu'il confirme son nouveau mot de passe.
                return HttpResponse('An email has been sent to you to confirm your new password')
        else:
            data = json.loads(request.body)
            Email = data['email']
            Password = data['password']

            if User.objects.filter(Email=Email).exists():
                send_email_forget_pass(Email, Password).send()
                return HttpResponse('An email has been sent to you to confirm your new password')
        return HttpResponse('Email does not exist we cannot change your password')
    return render(request, 'forgetPass.html')

def delete_useless_users():
    delMode = User.objects.all()
    for delete in delMode:
        if delete.IsVerified == False:
            delete.delete()

def signin(request):
    # delete_useless_users()
    if request.method == 'POST':
        if request.POST.get('email') and request.POST.get('password'):
            use = User()

            use.Email = request.POST.get('email')
            use.Password = request.POST.get('password')
            if User.objects.filter(Email=use.Email).exists():
                user = User.objects.get(Email=use.Email)
                if user.Password == use.Password and user.IsVerified == True:
                    return JsonResponse({'username' : user.FirstName + " " + user.LastName, 'Token' : user.Token})
        else:
            data = json.loads(request.body)
            use = User()
            use.Email = data['email']
            use.Password = data['password']
            if User.objects.filter(Email=use.Email).exists():
                user = User.objects.get(Email=use.Email)
                if user.Password == use.Password and user.IsVerified == True:
                    return JsonResponse({'username' : user.FirstName + " " + user.LastName, 'Token' : user.Token})
        return JsonResponse({'message' : 'invalid mail or password'}, status=400)
    return render(request, 'signin.html')