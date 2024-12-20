import 'dart:convert';
import 'package:frontend/backurls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String url = '${BackUrls.urlsbackend}/auth';

  // static Future<String?> getAccountType() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('account');
  // }

  static Future<void> fetchToken(String username, String password) async {

    final response = await http.post(
      Uri.parse('$url/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    print(username);
    if (response.statusCode == 201) {

      final prefs = await SharedPreferences.getInstance();
      var data = json.decode(response.body);
    
      // Get access token and refresh token from the response
      String accessToken = data['access'];
      String refreshToken = data['refresh'];
      String accountType = data['account'];

      // Save the tokens
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setString('account', accountType);
      
    } else {
      throw Exception('Failed to fetch token');
    }
  }

  // Get acces token by refresh token
  static Future<void> getaccessToken(String refresh) async {
    final response = await http.post(
      Uri.parse('$url/token/refresh/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'refresh': refresh,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = json.decode(response.body);

      // Get access token from the response
      String accessToken = data['access'];
      await prefs.setString('access_token', accessToken);
    } else {
      throw Exception('Failed to get access token');
    }
  }


}
