import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/backurls.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAPI {
  static const String url = "${BackUrls.urlsbackend}/profiles/me";

  static Future<Profile> getMyProfile() async {
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
        Uri.parse(url),
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
    final Map<String, String> requestBody = {};

    // Chỉ thêm các trường không null vào requestBody
    if (profile.name != null && profile.name != "") { 
      requestBody['name'] = profile.name!;
    }
    if (profile.birthday != null && profile.birthday != "") {
      requestBody['birthday'] = profile.birthday!;
    }
    if (profile.address != null && profile.address != "") {
      requestBody['address'] = profile.address!;
    }
    if (profile.avatar != null && profile.avatar != "") {
      requestBody['avatar'] = profile.avatar!;
    }
    if (profile.email != null && profile.email != "") {
      requestBody['email'] = profile.email!;
    }
  print(requestBody);
    var response = await http.put(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(requestBody), // Chỉ gửi các trường không null
    );
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
        body: json.encode(requestBody), // Chỉ gửi các trường không null
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