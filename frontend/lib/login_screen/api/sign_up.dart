import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpApi {
  static const String url = 'http://10.0.5.32:8000/auth';


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