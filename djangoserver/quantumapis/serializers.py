from rest_framework import serializers
from .models import *

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

class FileUploadSerializer(serializers.Serializer):
    file = serializers.FileField()

class ReqSerializer(serializers.ModelSerializer):
    class Meta:
        model = RequestTemp
        fields = "__all__"

class BaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = BaseTemp
        fields = "__all__"

class AttachSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attachments
        fields = "__all__"

"""
def create(self, validated_data):
        # You can customize this method to handle the file upload
        # and extract the filename from the Content-Disposition header.
        file = validated_data['file']
        # Extract the filename from the Content-Disposition header
        content_disposition = self.context['request'].headers.get('Content-Disposition', '')
        filename = self.extract_filename(content_disposition)
        # Save the file with the extracted filename
        file.name = filename
        # You may want to customize the file save logic here
        return file

    def extract_filename(self, content_disposition):
        # Extract filename from Content-Disposition header
        if 'filename=' in content_disposition:
            _, filename = content_disposition.split('filename=')
            return filename.strip(' "')
        return 'unknown_file'
"""