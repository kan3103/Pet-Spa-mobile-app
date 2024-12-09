from .models import Pet,Profile
from rest_framework import serializers

class PetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pet
        fields = ['name', 'dob', 'description', 'image', 'vaccinated', 'pet_type']
        
        
class ProfileSerializer(serializers.ModelSerializer):
    email = serializers.CharField(source='user.email', read_only=True)
    class Meta:
        model = Profile
        fields = ['name','birthday','address','avatar','email']
    def get_name(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"