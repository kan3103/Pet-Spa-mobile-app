import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/backurls.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class ProfileAPI {
  static const String url = "${BackUrls.urlsbackend}/profiles";

  static Future<Profile> getMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.get(
      Uri.parse('$url/me/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );

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
      response = await http.get(
        Uri.parse('$url/me/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
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

  static Future<Profile> getUserProfile(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.get(
      Uri.parse('$url/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );

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
      response = await http.get(
        Uri.parse('$url/$id/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
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

  static Future<Profile> UpdateProfile(Profile profile) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    print("helllpppp ${profile.avatar}");
    var request = http.MultipartRequest('PUT', Uri.parse("$url/me/"));
        if(profile.avatar!=""){request.files.add(await http.MultipartFile.fromPath(
          'avatar',
          profile.avatar!,
          filename: basename(profile.avatar!),
    ));}
    // Chỉ thêm các trường không null vào requestBody
    if (profile.name != null && profile.name != "") { 
      request.fields['name'] = profile.name!;
    }
    if (profile.birthday != null && profile.birthday != "") {
      request.fields['birthday'] = profile.birthday!;
    }
    if (profile.address != null && profile.address != "") {
      request.fields['address'] = profile.address!;
    }
    if (profile.email != null && profile.email != "") {
      request.fields['email'] = profile.email!;
    }
    request.headers['Authorization'] = 'Bearer $access_token';
    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    final response = await request.send();
   
    // var response = await http.put(
    //   Uri.parse('$url/'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Authorization': 'Bearer $access_token',
    //   },
    //   body: json.encode(<String,String>{
    //     'name': '${profile.name}',
    //     'birthday': '${profile.birthday}',
    //     'address': '${profile.address}',
    //     'avatar': '${profile.avatar}',
    //     'email': '${profile.email}'
    //   }),
    // );

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();
      print(body);  
      var jsonData = json.decode(body); 
      dynamic data = json.decode(jsonData);
      print(data);
      Profile profile = Profile.fromJson(data); 
      return profile;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var request = http.MultipartRequest('PUT', Uri.parse("$url/me/"));
        if(profile.avatar!="")request.files.add(await http.MultipartFile.fromPath(
          'image',
          profile.avatar!,
          filename: basename(profile.avatar!),
    ));
    // Chỉ thêm các trường không null vào requestBody
    if (profile.name != null && profile.name != "") { 
      request.fields['name'] = profile.name!;
    }
    if (profile.birthday != null && profile.birthday != "") {
      request.fields['birthday'] = profile.birthday!;
    }
    if (profile.address != null && profile.address != "") {
      request.fields['address'] = profile.address!;
    }
    if (profile.email != null && profile.email != "") {
      request.fields['email'] = profile.email!;
    }
    request.headers['Authorization'] = 'Bearer $access_token';
    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    final response = await request.send();

      if (response.statusCode == 200) {
         String body = await response.stream.bytesToString();
          var jsonData = json.decode(body); 
          dynamic data = json.decode(jsonData);
          print(data);
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