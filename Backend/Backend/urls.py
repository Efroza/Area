"""Backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

##
# @file urls.py
# @brief Ce programme permet de setUp les différentes routes du serveur.
# @sections Les différentes routes :
#   - service/ : permet d'accèder aux différents services disponibles.
#   - login/ : permet d'accèder aux différentes routes du login.
#   - applet/ : permet d'accèder aux différents applets disponibles.
#   - about.json : permet d'accèder aux informations du serveur.

from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from . import views

urlpatterns = [
    path('service/', include('Service.urls')),
    path('login/', include('Login.urls')),
    path('applet/', include('applet.urls')),
    # path('admin/', admin.site.urls),
    path('', include('Login.urls')),
    path('about.json', views.about)
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)