from django.contrib import admin
from django.urls import path
from . import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path("login/",views.loginuser),
    path("signup/",views.profilesetup),
    path("allusers/",views.allusers),
    path("updateip/",views.updateip),
    path("attach/<int:mid>/<int:level>",views.uploadattachments),
    path("emailreq/",views.emailreq),
    path("emailbyid/<int:eid>",views.emailbyid),
    path("attachforemail/<int:eid>",views.attachbyid),
    path("setonline/<int:uid>",views.isonline),
    path("setoffline/<int:uid>",views.isoffline),
    path("getrecip/<str:recem>",views.receiverip),
    path("storebases/<int:mid>",views.getbases),
    path("allbases/",views.allbases),
    path("allmails/",views.allemails),
    path("decryptemail/<int:mid>",views.decryptemail),
    path("decryptattach/<int:mid>",views.decryptattach),
    path("otpencrypt/<str:message>/<int:mid>",views.otpencrypt),
    path("getattach/<str:fname>",views.downloadattach)
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
