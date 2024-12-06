import 'dart:convert';
import 'package:frontend/backurls.dart';
import 'package:http/http.dart' as http;

class SignUpApi {
  static const String url = '${BackUrls.urlsbackend}/auth';


  static Future<void> signupcus(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      print(data);
    } else {
      throw Exception('Failed to fetch token');
    }
  }
}