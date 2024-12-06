import 'dart:convert';
import 'package:frontend/backurls.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:frontend/service_screen/models/Pet.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/service_screen/models/listService.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> formatOrderFile(Map<String, dynamic> jsonString) {
  /*
String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}*/
List<Map<String, dynamic>> formattedData = jsonString.entries.map((entry) {
    print(entry.key == null ? 'ERROR' :entry.key);
    return {
      "name": entry.key == null ? "ERROR" :entry.key ,
      "orders": entry.value.map((order) {
        return {
          "id": order['id'],
          "user_id": order['user_id'],
          "created_at": order['created_at'],
          "status": order['status'],
          "staff_id": order['staff_id'],
          "pet_id": order['pet_id'],
          "service_id": order['service_id']
        };
      }).toList(),
    };
  }).toList();

return formattedData;
}

class AllServiceAPI {
  static const String url = "${BackUrls.urlsbackend}/orders/services/all";
  

  static Future<List<Map<String,dynamic>>> getList() async {
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
      return formatOrderFile(data);
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
        return formatOrderFile(data);
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }

  static Future<List<Pet>> getPetnow() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/profiles/pet/list/now/'),
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
}
