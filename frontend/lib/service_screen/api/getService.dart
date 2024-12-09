import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/backurls.dart';
import 'package:frontend/class_model/orderServiceDetail.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:frontend/service_screen/models/Pet.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/service_screen/models/listService.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<Map<String, dynamic>> formatFile(Map<String, dynamic> jsonString,accountType) {
  
String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}
List<Map<String, dynamic>> formattedData = jsonString.entries.map((entry) {
  
    return accountType == "customer" ? {
      "name": entry.key,
      "orders": entry.value["orders"].map((order) {
        return {
          "id": order["id"],
          "status": order["status"],
          "pet": order["pet"],
          "service": order["service"],
        };
      }).toList(),
      "type": PetType(entry.value["type"]),
      "image": entry.value["orders"][0]["image_pet"],
    }:{
      "name": entry.key,
      "orders": entry.value["orders"].map((order) {
        return {
          "id": order["id"],
          "status": order["status"],
          "pet": order["pet"],
          "service": order["service"],
        };
      }).toList(),
      "type": PetType(entry.value["type"]),
    };
  }).toList()
  ;

return formattedData;
}


class ServiceAPI {
  static const String url = "${BackUrls.urlsbackend}/orders/services";
  

  static Future<List<Map<String,dynamic>>> getList() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    String? accountType = prefs.getString('account');
    var response = await http.get(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
  
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      print(formatFile(data,accountType!));
      return formatFile(data,accountType!);
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
        dynamic data = json.decode(response.body);
        return formatFile(data,accountType!);
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }

  static Future<orderServiceDetail> getorderdetail(String id) async {
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
      orderServiceDetail order = orderServiceDetail.fromJson(data);
      return order;
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
        orderServiceDetail order = orderServiceDetail.fromJson(data);
        return order;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get order detail");
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


  static Future<void> PostService(List<Map<String,dynamic>> service) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.post(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        "pets": service, // Gửi toàn bộ danh sách service
      }),
    );
    if (response.statusCode == 201) {
      print("Post success");
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var response = await http.post(
        Uri.parse('$url/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: json.encode({
          "pets": service, // Gửi toàn bộ danh sách service
        }),
      );

      if (response.statusCode == 201) {
        print("Post success");
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }
}