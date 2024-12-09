import 'dart:convert';

import 'package:frontend/backurls.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ManagerAPI {
  static void addStaff(String username, String password, String email, String lastname, String firstname) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.post(
      Uri.parse('${BackUrls.urlsbackend}/auth/register/staff/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(
        {
          "username": username,
          "password": password,
          "email": email,
          "last_name": lastname,
          "first_name":firstname,
        }
      ),
    );
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var response = await http.post(
      Uri.parse('${BackUrls.urlsbackend}/auth/register/staff/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(
        {
          "username": username,
          "password": password,
          "email": email,
          "last_name": lastname,
          "first_name":firstname,
        }
      ),
    );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to add Staff");
    }
  }
}