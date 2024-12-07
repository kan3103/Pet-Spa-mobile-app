import 'dart:convert';

import 'package:frontend/backurls.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_screen/models/Pet.dart';

class ServiceAPI {
  static const String url = "${BackUrls.urlsbackend}/orders/services";
  
  static get http => null;
  


  static Future<List<Pet>> getPet() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/profiles/pet/list/all/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Pet> pets = data.map((json) => Pet.fromJson(json)).toList();
      return pets;
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
        List<dynamic> data = json.decode(response.body);
        List<Pet> pets = data.map((json) => Pet.fromJson(json)).toList();
        return pets;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }


  // static Future<void> PostService(List<Map<String,dynamic>> service) async{
  //   final prefs = await SharedPreferences.getInstance();
  //   String? access_token = prefs.getString('access_token');
  //   String? refresh_token = prefs.getString('refresh_token');

  //   var response = await http.post(
  //     Uri.parse('$url/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $access_token',
  //     },
  //     body: json.encode({
  //       "pets": service, // Gửi toàn bộ danh sách service
  //     }),
  //   );
  //   if (response.statusCode == 201) {
  //     print("Post success");
  //   } else if (response.statusCode == 401) {
  //     // Refresh the access token using the refresh token
  //     await TokenStorage.getaccessToken(refresh_token!);

  //     // Retry the request with the new access token
  //     access_token = prefs.getString('access_token');
  //     var response = await http.post(
  //       Uri.parse('$url/'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $access_token',
  //       },
  //       body: json.encode({
  //         "pets": service, // Gửi toàn bộ danh sách service
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       print("Post success");
  //     } else {
  //       throw Exception("Failed to get profile after retrying with new token");
  //     }
  //   } else {
  //     throw Exception("Failed to get profile");
  //   }
  // }
}