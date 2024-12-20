import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/backurls.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<bool> loginWithGoogle(String accessToken) async {
    final response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/auth/google/').replace(queryParameters: {"access_token": accessToken}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      try {
        String email = data['email'];
        String firstName = data['first_name'];
        String lastName = data['last_name'];
        String avatar = data['avatar'];
        await prefs.setString('email', email);
        await prefs.setString('first_name', firstName);
        await prefs.setString('last_name', lastName);
        await prefs.setString('avatar', avatar);
        return false;
      } catch (e) {
        String accessToken = data['access'];
        String refreshToken = data['refresh'];
        String accountType = data['account'];
        // Lưu các token vào SharedPreferences
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        await prefs.setString('account', accountType);
        return true;
      }

    } else {
      throw Exception('Failed to signin');
    }
  }
  static Future<void> SigninwithGoogle(String username,String accessToken) async{
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? last_name = prefs.getString('last_name');
    String? first_name = prefs.getString('first_name');
    String? avatar = prefs.getString('avatar');
    print(avatar);
    final response = await http.post(
      Uri.parse('${BackUrls.urlsbackend}/auth/google/'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String,String>{
        'username': username,
        'email': '$email',
        'last_name': '$last_name',
        'first_name': '$first_name',
        'avatar': '$avatar',
        'access_token':accessToken
      }),
    );

    if (response.statusCode == 201){
      prefs.remove('username');
      prefs.remove('email');
      prefs.remove('last_name');
      prefs.remove('first_name');
      prefs.remove('avatar');
      final data = jsonDecode(response.body);


      String accessToken = data['access'];
      String refreshToken = data['refresh'];
      String accountType = data['account'];

      // Lưu các token vào SharedPreferences
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setString('account', accountType);
    }
    else {
      throw Exception('Failed to signin');
    }
  }
}