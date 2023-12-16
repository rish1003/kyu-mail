from django.http import HttpResponse,FileResponse
from .models import *
from qiskit import *
from numpy.random import randint
from rest_framework.decorators import api_view,parser_classes
from rest_framework.response import Response
from rest_framework import status
from .serializers import *
from rest_framework.parsers import FileUploadParser,MultiPartParser
import os
import requests
from numpy.random import randint
import hashlib
from Crypto import Random
from Crypto.Cipher import AES
from base64 import b64encode, b64decode
from Crypto.Util.Padding import pad,unpad

@api_view(['POST'])
def loginuser(request):
    try:
        email = request.data.get("email")
        password = request.data.get("pass")

        user = User.objects.get(email=email)

        if user.passtoken == password:
            return Response({"message": "valid"}, status=status.HTTP_200_OK)
        else:
            return Response({"message": "incorrect password"}, status=status.HTTP_401_UNAUTHORIZED)
    except User.DoesNotExist:
        return Response({"message": "no user found"}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
#use this profile setup itself to sign uo a new gmail user
@api_view(['POST'])
@parser_classes([MultiPartParser, FileUploadParser])
def profilesetup(request):
    if request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            file_serializer = FileUploadSerializer(data=request.data)
            if file_serializer.is_valid():
                file_serializer.save()
            return Response({'message': 'User created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    if request.method == 'PUT':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            file_serializer = FileUploadSerializer(data=request.data)
            if file_serializer.is_valid():
                file_serializer.save()
            return Response({'message': 'User created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    return Response({'error': 'Invalid method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['GET'])
def allusers(request):
    try:
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['POST'])
def updateip(request):
    try:
        ip = request.data.get("ip")
        email = request.data.get("email")
        user = User.objects.get(email=email)
        user.currIP = ip
        user.save()
        return Response({"message": "IP updated successfully"}, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['POST'])
@parser_classes([FileUploadParser])
def uploadattachments(request,mid,level):
    if request.method == 'POST':
        serializer = FileUploadSerializer(data=request.data)

        if serializer.is_valid():
            # Access the uploaded file through serializer.validated_data['file']
            file_instance = serializer.validated_data['file']

            upload_dir = 'media/uploads'

            a=Attachments.objects.create()
            a.reqid=mid
            # Construct the file path in the upload directory
            file_path = os.path.join(upload_dir, file_instance.name)
            
            # Ensure the directory exists, create it if not
            if not os.path.exists(upload_dir):
                os.makedirs(upload_dir)
            a.path=file_instance.name   

            with open(file_path, 'wb') as destination:
                for chunk in file_instance.chunks():
                    destination.write(chunk)
            if level!=1:
                with open(file_path, 'rb') as file:
                    pdf_content = file.read()
                s=BaseTemp.objects.get(mid=mid)
                key=s.key
                if level==2:
                    data=aesencrypt(pdf_content,key,2)
                if level==3:
                    data=otpencrypt(pdf_content,key)
                if level==4:
                    data=level4encrypt(pdf_content,key)
                if level==5:
                    data=level5encrypt(pdf_content,key)
                with open(file_path, 'w') as output_file:
                    output_file.write(data)
                a.save()
            return Response({'message':'File uploaded successfully'}, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['GET'])
def allattach(request):
    try:
        users = Attachments.objects.all()
        serializer = AttachSerializer(users, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['GET'])
def allbases(request):
    try:
        bases = BaseTemp.objects.all()
        serializer = BaseSerializer(bases, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def allemails(request):
    try:
        reqs = RequestTemp.objects.all()
        serializer = ReqSerializer(reqs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@parser_classes([MultiPartParser, FileUploadParser])
def emailreq(request):
    send=request.POST.get("sender")
    rec=request.POST.get("receiver")
    text=request.POST.get("message")
    sbase=request.POST.get("sbase")
    rbase=request.POST.get("rbase")
    level=request.POST.get("level")

    re=User.objects.get(email=rec)
    if re.isOnline==0:
        return Response({"message":"user is offline"})
    
    r=RequestTemp.objects.create()
    r.sender=send
    r.receiver=rec

    file_data_list = request.FILES.getlist("files")

    if level==1:
        r.message=text
    else:       
        try:
            setbases=requests.post("http://localhost:8000/storebases/"+str(r.id),data={"sbase":sbase,"rbase":rbase})
        except Exception as e:
            return HttpResponse(str(e))
        key=keytoencrypt(r.id)
        se=User.objects.get(email=send)
        se.keys-=1
        if level==2:
            r.message=aesencrypt(text,key)
        if level==3:
            r.message=otpencrypt(text,key)
        if level==4:
            r.message=level4encrypt(text,key)
        if level==5:
            r.message=level5encrypt(text,key)

    if file_data_list!=None or file_data_list!=[]:
        for file_data in file_data_list:
            # Call the file_upload_view to handle each file individually
            try:
                resp=requests.post("http://localhost:8000/attach/"+str(r.id)+"/"+str(level),headers={"Content-Disposition":"attachment; filename="+file_data.name},data={"file":file_data})
            except Exception as e:
                return HttpResponse(str(e))
    r.save()
    return Response({"message": "Request processed successfully"}, status=status.HTTP_200_OK)

@api_view(['GET'])
def emailbyid(request, eid):
    try:
        e = RequestTemp.objects.get(id=eid)
        serializer = ReqSerializer(e)  # Replace with your actual serializer
        return Response(serializer.data)
    except RequestTemp.DoesNotExist:
        return Response({"error": "Email not found"}, status=404)
    
@api_view(['GET'])
def attachbyid(request, eid):
    try:
        attachlist=[]
        e = Attachments.objects.filter(reqid=eid)
        for i in e:
            serializer = AttachSerializer(i) 
            attachlist.append(serializer.data) # Replace with your actual serializer
        return Response(attachlist)
    except Attachments.DoesNotExist:
        return Response({"error": "Attachments not found"}, status=404)

@api_view(["GET"])
def isonline(request, uid):
    try:
        user = User.objects.get(id=uid)
        user.isOnline = 1
        user.save()
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(["GET"])
def isoffline(request, uid):
    try:
        user = User.objects.get(id=uid)
        user.isOnline = 0
        user.save()
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(["GET"])
def receiverip(request,recem):
    r=User.objects.get(email=recem)
    if r.isOnline==0:
        return Response({"message":"oopsie"})
    return Response({"receiverip":r.currIP})
    
@api_view(["POST"])
def getbases(request,mid):
    sbase=request.POST.get("sbase")
    rbase=request.POST.get("rbase")
    r=BaseTemp.objects.create()
    ra=randint(2,size=1000)
    r.mid=mid
    r.sbase=sbase
    r.rbase=rbase
    r.sendbits=ra
    r.save()
    return Response("done")

@api_view(["GET"])
def decryptemail(request,mid):
    m=RequestTemp.objects.get(id=mid)
    l=m.level
    returnmessage=""
    if m==1:
        returnmessage=m.message
    else:
        b=BaseTemp.objects.get(mid=mid)
        k=b.key
        enc=m.message
        if l==2 or l==0:
            returnmessage=aesdecrypt(enc,k)
        #do for all other lebels
    return Response({"message":returnmessage})

@api_view(["GET"])
def decryptattach(request,mid):
    a=Attachments.objects.filter(reqid=mid)
    for i in a:
        file_path=i.path
        b=BaseTemp.objects.get(mid=mid)
        r=RequestTemp.objects.get(id=mid)
        level=r.level
        k=b.key
        with open("media/uploads/finaldocu.pdf", 'rb') as file:
            pdf_content = file.read()
        s=BaseTemp.objects.get(mid=mid)
        key=s.key
        data=""
        if level==0:
            data=aesdecrypt(pdf_content,key,2)
        if level==3:
            data=otpencrypt(pdf_content,key)
        if level==4:
            data=level4encrypt(pdf_content,key)
        if level==5:
            data=level5encrypt(pdf_content,key)
        with open("media/uploads/output.pdf", 'wb') as output_file:
            output_file.write(data)
    return Response("done")

def decryptaes(request,mid):
    m=RequestTemp.objects.get(id=mid)
    enc=m.message
    b=BaseTemp.objects.get(mid=mid)
    k=b.key
    return Response(aesdecrypt(enc,k))

def keytoencrypt(mid):
    m=BaseTemp.objects.get(mid=mid)
    sbase=m.sbase
    rbase=m.rbase
    ma=m.sendbits
    if m.key=="":
        key=remove_garbage(sbase,rbase,ma)
        key=[bit for bit in key if bit!=" " and bit!="\n"]
        key="".join(key)
        m.key=key
    else:
        return m.key
    m.save()
    return key

def keytodecrypt(mid):
    m=BaseTemp.objects.get(id=mid)
    sbase=m.sbase
    rbase=m.rbase
    key=m.key
    m.save()
    return key

def encode_message(sender_bits,sender_bases):
    message = []
    for i in range(1000):
        qc = QuantumCircuit(1,1)
        if sender_bases[i] == 0: 
            if sender_bits[i] == 0:
                pass 
            else:
                qc.x(0)
        else:
            if sender_bits[i] == 0:
                qc.h(0)
            else:
                qc.x(0)
                qc.h(0)
        message.append(qc)

def measure_message(message, bases):
    measurements = []
    for q in range(1000):
        if bases[q] == 0: 
            message[q].measure(0,0)
        if bases[q] == 1: 
            message[q].h(0)
            message[q].measure(0,0)
        aer_sim = BasicAer.get_backend('qasm_simulator')
        result = aer_sim.run(message[q], shots=100, memory=True).result()
        measured_bit = int(result.get_memory()[0])
        measurements.append(measured_bit)
    return measurements

def remove_garbage(a_bases, b_bases, bits):
    good_bits = []
    #represents bits in bases that actually match
    print("alice",len(a_bases))
    print("bob",len(b_bases))
    for q in range(1000):
        if a_bases[q] == b_bases[q]:
            # If both used the same basis, add
            # this to the list of 'good' bits
            good_bits.append(bits[q])
    return good_bits

def aesencrypt(message,key,type):
    message = aespad(message)
    key=key[:int(AES.key_size[1])]
    iv = Random.new().read(AES.block_size)
    key_bytes = key.encode('utf-8')
    cipher = AES.new(key_bytes, AES.MODE_CBC, iv)
    if type==1:
        encrypted_text = cipher.encrypt(message.encode())
    if type==2:
        encrypted_text = cipher.encrypt(message)
    return b64encode(iv + encrypted_text).decode("utf-8")

def otpencrypt(message,key):
    return message

def level4encrypt(message,key):
    return message

def level5encrypt(message,key):
    return message

def aespad(message):
    padded_content= pad(message, AES.block_size)
    return padded_content

def aesunpad(text):
    last_character = text[len(text) - 1:]
    bytes_to_remove = ord(last_character)
    return text[:-bytes_to_remove]

def aesdecrypt(message,key,type):
    message = b64decode(message)
    iv = message[:AES.block_size]
    key=key[:int(AES.key_size[1])]
    key_bytes = key.encode('utf-8')
    cipher = AES.new(key_bytes, AES.MODE_CBC, iv)
    if type==1:
        plain_text = cipher.decrypt(message[AES.block_size:]).decode("utf-8")
    if type==2:
        ciphertext = message[AES.block_size:]
        plain_text = cipher.decrypt(ciphertext)
    return aesunpad(plain_text)

@api_view(["GET"])
def otpencrypt(request,message,mid):
    messagebytes=bytes(message,encoding="utf-8")
    b=BaseTemp.objects.get(mid=mid)
    key=b.key
    key=[i for i in key]
    enc=""
    for i in range(0,len(messagebytes),1000):
        sub=messagebytes[0:i+1]
        encrypted_message = bytes([int(m) ^ int(k) for m, k in zip(sub, key)])
        enc+=str(encrypted_message)
    return Response(enc)

@api_view(["GET"])
def downloadattach(request,fname):
    try:
        # Open the file in binary mode
        with open("media/uploads/"+fname, 'rb') as pdf_file:
            # Use FileResponse to send the file as the response
            response = FileResponse(pdf_file, content_type='application/pdf')
            response['Content-Disposition'] = 'attachment; filename="'+fname+'"'
            return response
    except FileNotFoundError:
        return Response({'error': 'File not found'}, status=404)
    except Exception as e:
        return Response({'error': f'Error: {str(e)}'}, status=500)