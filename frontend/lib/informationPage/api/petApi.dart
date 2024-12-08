import 'dart:convert';
import 'dart:io';

import 'package:frontend/backurls.dart';
import 'package:frontend/login_screen/api/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../service_screen/models/Pet.dart';
import 'package:path/path.dart'; // Để lấy tên file từ đường dẫn


class PetAPI {
  static const String url = "${BackUrls.urlsbackend}/orders/services";
  
  static String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}

  static void addPet(Pet pet) async{
    
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');
    String filePath = "";
    if(pet.image!=null) filePath  = pet.image!;


    var request = http.MultipartRequest('POST', Uri.parse("${BackUrls.urlsbackend}/profiles/pet/register/"));
    if(filePath!="")request.files.add(await http.MultipartFile.fromPath(
      'image',
      filePath,
      filename: basename(filePath),
    ));
  // Thêm trường "name" vào body
    request.fields['name'] = pet.name!;
    if(pet.dob!=null && pet.dob!="")request.fields['dob'] = pet.dob!;
    if(pet.description!=null && pet.description!="")request.fields['description'] = pet.description!;
    if(pet.vaccinated!=null ) request.fields['vaccinated'] = pet.vaccinated! ? "true" : "false";
    request.fields['pet_type'] = pet.petType.toString();
    request.headers['Authorization'] = 'Bearer $access_token';
    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    final response = await request.send();


    var response1= await http.post(
      Uri.parse('${BackUrls.urlsbackend}/profiles/pet/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode(pet.toJson()),
    );
    
    // print(pet.toJson());
    // print(response.statusCode);
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 401) {
      // Refresh the access token using the refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      var request = http.MultipartRequest('POST', Uri.parse("${BackUrls.urlsbackend}/profiles/pet/register/"));
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        filePath,
        filename: basename(filePath),
      ));
    // Thêm trường "name" vào body
      request.fields['name'] = pet.name!;
      if(pet.dob!=null && pet.dob!="")request.fields['dob'] = pet.dob!;
      if(pet.description!=null && pet.description!="")request.fields['description'] = pet.description!;
      if(pet.vaccinated!=null ) request.fields['vaccinated'] = pet.vaccinated! ? "true" : "false";
      request.fields['pet_type'] = pet.petType.toString();
      request.headers['Authorization'] = 'Bearer $access_token';
      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      final response = await request.send();
    //   response = await http.post(
    //     Uri.parse('${BackUrls.urlsbackend}/profiles/pet/register/'),
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Authorization': 'Bearer $access_token',
    //     },
    //     body: json.encode(pet.toJson()),
    //   );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception("Failed to get profile after retrying with new token");
      }
    } else {
      throw Exception("Failed to add Pet");
    }
  }


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