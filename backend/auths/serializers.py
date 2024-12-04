from rest_framework import serializers
from .models import Customer,User,Staff

class CusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ['username', 'email','password']
        extra_kwargs = {"password":{"write_only":True}}
    def validate(self, data):
        if User.objects.filter(username=data['username']).exists():
            raise serializers.ValidationError("Username already exists.")
        
        if User.objects.filter(email=data['email']).exists():
            raise serializers.ValidationError("Email already exists..")
        
        return data

    def create(self, validated_data):
        user = Customer(
            username=validated_data['username'],
            email=validated_data['email']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

class StaffSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ['username', 'email','password','last_name','first_name']
        extra_kwargs = {"password":{"write_only":True}}
    def validate(self, data):
        if User.objects.filter(username=data['username']).exists():
            raise serializers.ValidationError("Username already exists.")
        
        if User.objects.filter(email=data['email']).exists():
            raise serializers.ValidationError("Email already exists..")
        
        return data

    def create(self, validated_data):
        user = Staff(
            username=validated_data['username'],
            email=validated_data['email'],
            last_name=validated_data['last_name'],
            first_name=validated_data['first_name']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user
class TokenSerializer(serializers.Serializer):
    refresh = serializers.CharField()
    access = serializers.CharField()
        