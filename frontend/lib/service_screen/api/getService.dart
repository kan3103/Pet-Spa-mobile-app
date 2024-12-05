import 'dart:convert';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/service_screen/models/listService.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> formatFile(Map<String, dynamic> jsonString) {
  // String jsonString = '''
  // {
  //   "khangLy": {
  //     "orders": [
  //       {
  //         "id": 1,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 2,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 3,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 4,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "hihihi"
  //       }
  //     ],
  //     "type": 1
  //   },
  //   "khangle": {
  //     "orders": [
  //       {
  //         "id": 1,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 2,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 3,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "vangu"
  //       },
  //       {
  //         "id": 4,
  //         "status": 1,
  //         "pet": "khangLy",
  //         "service": "hihihi"
  //       }
  //     ],
  //     "type": 1
  //   }
  // }
  // ''';

String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}
List<Map<String, dynamic>> formattedData = jsonString.entries.map((entry) {
    return {
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
  }).toList();

return formattedData;
}



class ServiceAPI {
  static const String url = "http://10.0.5.30:8000/orders/services";
  

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
      return formatFile(data);
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
        return formatFile(data);
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }
}