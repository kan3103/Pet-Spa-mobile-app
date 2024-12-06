import 'dart:convert';
import 'package:frontend/backurls.dart';
import 'package:frontend/class_model/models/Staff.dart';
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
    //print(entry.key == null ? 'ERROR' :entry.key);
    return {
      "name": entry.key == null ? "ERROR" :entry.key ,
      "orders": entry.value.map((order) {
        return {
          "id": order['id'],
          "status": order['status'],
          "staff_id": order['staff'],
          "pet_id": order['pet'],
          "service_id": order['service'],
          "image": order['service_img']
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      //print(data);
      return formatOrderFile(data) ;
      
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
      return formatOrderFile({
    "khang": [
        {
            "id": 1,
            "user_id": 1,
            "created_at": "2024-12-05T16:36:43.555Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 1,
            "service_id": 1
        },
        {
            "id": 2,
            "user_id": 1,
            "created_at": "2024-12-05T16:46:10.208Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 1,
            "service_id": 1
        },
        {
            "id": 3,
            "user_id": 1,
            "created_at": "2024-12-05T16:55:18.123Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 1,
            "service_id": 1
        },
        {
            "id": 4,
            "user_id": 1,
            "created_at": "2024-12-05T16:55:18.127Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 1,
            "service_id": 2
        },
        {
            "id": 5,
            "user_id": 1,
            "created_at": "2024-12-05T17:53:13.172Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 1
        },
        {
            "id": 6,
            "user_id": 1,
            "created_at": "2024-12-05T17:53:13.177Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 2
        },
        {
            "id": 7,
            "user_id": 1,
            "created_at": "2024-12-05T17:53:35.645Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 1
        },
        {
            "id": 8,
            "user_id": 1,
            "created_at": "2024-12-05T17:53:35.648Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 2
        }
    ],
    "bach": [
        {
            "id": 9,
            "user_id": 2,
            "created_at": "2024-12-05T17:55:16.972Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 1
        },
        {
            "id": 10,
            "user_id": 2,
            "created_at": "2024-12-05T17:55:16.977Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 2
        },
        {
            "id": 11,
            "user_id": 2,
            "created_at": "2024-12-05T18:10:40.098Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 1
        },
        {
            "id": 12,
            "user_id": 2,
            "created_at": "2024-12-05T18:10:40.101Z",
            "status": 1,
            "staff_id": null,
            "pet_id": 2,
            "service_id": 2
        }
    ]
});
      // throw Exception("Failed to get profile");
    }
  }
  static Future<List<Staff>> getStaffnow() async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.get(
      Uri.parse('${BackUrls.urlsbackend}/profiles/staffs/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Staff> staff = data.map((json) => Staff.fromJson(json)).toList();
      return staff;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      response = await http.get(
        Uri.parse('${BackUrls.urlsbackend}/profiles/staffs/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
         List<dynamic> data = json.decode(response.body);
        List<Staff> staff = data.map((json) => Staff.fromJson(json)).toList();
        return staff;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }
  static Future<void> PutStaff(int id , int service) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    var response = await http.put(
      Uri.parse('${BackUrls.urlsbackend}/orders/services/${service}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        "staff": id, // Gửi toàn bộ danh sách service
      }),

    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var response = await http.put(
      Uri.parse('${BackUrls.urlsbackend}/orders/services/${service}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        "staff": id, // Gửi toàn bộ danh sách service
      }),

    );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to get profile");
    }
  }
  /*
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
  }*/
}
