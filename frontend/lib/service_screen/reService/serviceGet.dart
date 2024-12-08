import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/backurls.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetService {
  static const String url = "${BackUrls.urlsbackend}/store/services";

  static Future<List<ServiceItem>> GetAllService() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
  
    var response = await http.get(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
       List<dynamic> data = json.decode(response.body);
      List<ServiceItem> items = data.map((json) => ServiceItem.fromJson(json)).toList();
      return items;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      response = await http.get(
        Uri.parse('$url/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ServiceItem> items = data.map((json) => ServiceItem.fromJson(json)).toList();
        return items;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }


  static Future<void> PostService(String name,int price,String description) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    print(name);
    print(json.encode(<String,dynamic>{
        "name":name,
        "price":price,
        "description":description
      }));
    var response = await http.post(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(<String,dynamic>{
        "name":name,
        "price":price,
        "description":description
      }),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      response = await http.get(
        Uri.parse('$url/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }

  static Future<Profile> UpdateProfile(Profile profile) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    print(profile.avatar);
    var response = await http.put(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(<String,String>{
        'name': '${profile.name}',
        'birthday': '${profile.birthday}',
        'address': '${profile.address}',
        'avatar': '${profile.avatar}',
        'email': '${profile.email}'
      }),
    );
    print("check");
    print(response.body);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      print(data);
      Profile profile = Profile.fromJson(data); 
      return profile;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var response = await http.put(
        Uri.parse('$url/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: json.encode(<String,String>{
          'name': '${profile.name}',
          'birthday': '${profile.birthday}',
          'address': '${profile.address}',
          'avatar': '${profile.avatar}',
          'email': '${profile.email}'
        }),
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Profile profile = Profile.fromJson(data); 
        return profile;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }
}