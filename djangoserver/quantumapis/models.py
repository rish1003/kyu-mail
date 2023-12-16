from django.db.models import *
import datetime

class User(Model):
    id=AutoField(primary_key=True,serialize=True)
    email=CharField(max_length=100)
    passtoken=CharField(max_length=10,default="")
    currIP=CharField(max_length=50,default="0.0.0.0")
    isOnline=IntegerField(default=0)
    keys=IntegerField(default=100)
    image=ImageField(upload_to="images/",default="none.jpg")

class RequestTemp(Model):
    id=AutoField(primary_key=True,serialize=True)
    sender=CharField(default="",max_length=100)
    receiver=CharField(default="",max_length=100)
    subject=CharField(max_length=100,default="")
    message=CharField(max_length=200)
    dateofsend=DateField(default=datetime.datetime.today())
    timeofsend=TimeField(default=datetime.datetime.now())
    replto=IntegerField(default=0)
    level=IntegerField(default=0)

class Attachments(Model):
    id=AutoField(primary_key=True,serialize=True)
    reqid=IntegerField(default=0)
    path=CharField(max_length=100,default="")
    file=BinaryField(default=b'\x00')
    
class BaseTemp(Model):
    id=AutoField(primary_key=True,serialize=True)
    mid=IntegerField(default=0)
    sbase=CharField(max_length=1000)
    rbase=CharField(max_length=1000)
    sendbits=CharField(max_length=1000,default="")
    key=CharField(max_length=20,default="")