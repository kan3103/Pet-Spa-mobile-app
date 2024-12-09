import 'dart:convert';

import 'package:frontend/backurls.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:frontend/productPage/cartItem.dart/cartServicemodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Cartapi {
  static Future<List<Cartservicemodel>> getOrderCart() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/orders/services?unpaid=1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
  
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<Cartservicemodel> order = (data['orders'] as List)
          .map((json) => Cartservicemodel.fromJson(json))
          .toList();

      return order;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/orders/services?unpaid=1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
  
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<Cartservicemodel> order = (data['orders'] as List)
          .map((json) => Cartservicemodel.fromJson(json))
          .toList();
      return order;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get order detail");
    }
  }

  static Future<void> Payment(List<int> orders) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.post(
      Uri.parse('${BackUrls.urlsbackend}/orders/services/pay/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        "orders": orders, 
      }),

    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var response = await http.post(
        Uri.parse('${BackUrls.urlsbackend}/orders/services/pay/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: json.encode({
          "orders": orders, // Gửi toàn bộ danh sách service
        }),

      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to payment");
    }
  }
}