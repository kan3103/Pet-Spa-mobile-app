from .models import Pet,Profile
from rest_framework import serializers

class PetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pet
        fields = ['name', 'dob', 'description', 'image', 'vaccinated', 'pet_type']
        
        
class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['birthday', 'avatar', 'address']