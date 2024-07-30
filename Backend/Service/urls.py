from django.urls import path
from . import views
from . import oauth2

urlpatterns = [
    path('', views.getService),
    path('add', views.postService),
    path('<int:id>', views.getServiceId),
    path('<str:name>', views.getServiceName),
    path('account/issubscribe/<str:service_name>', views.userEligibleService),
    path('account/<str:service_name>', views.postServiceAccount),
    path('account/oauth2/<str:service_name>', views.postServiceAccountOauth2),
    path('useInfo/<str:name>', views.getServiceUseInfo),
    path('needRegistration/<str:name>', views.needRegistration),
    path('accept/oauth2', oauth2.acceptoauth2Discord),
    path('set/redirect', oauth2.setRedirection),
    path('oauth2/flutter_test', views.acceptoauth2),
    path('oauth2/eligible/<str:service_name>', oauth2.serviceOauth2Elgible),
    path('accept/oauth2/twitter', oauth2.acceptoauth2twitter),
    path('accept/oauth2/code/twitter', oauth2.acceptoauth2twittersave)
]