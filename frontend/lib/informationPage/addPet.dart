import 'dart:convert';
import 'package:http/http.dart' as http;

class AddPetApi {
  // Địa chỉ URL của API (thay đổi theo địa chỉ server của bạn)
  static const String url = 'http://10.0.5.32:8000/pet';

  /// Hàm để thêm thú cưng mới
  static Future<void> addPet({
    required String name,
    required String dob,
    required bool vaccine,
    required String petType,
    String image = "", // Giá trị mặc định là chuỗi rỗng
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/pets/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          'name': name,
          'dob': dob,
          'vaccine': vaccine,
          'petType': petType,
          'image': image,
        }),
      );

      // Kiểm tra phản hồi từ server
      if (response.statusCode == 201) {
        // Nếu thêm thành công
        var data = json.decode(response.body);
        print('Pet added successfully: $data');
      } else {
        // Nếu xảy ra lỗi
        print('Failed to add pet: ${response.body}');
        throw Exception('Failed to add pet');
      }
    } catch (error) {
      // Bắt và hiển thị lỗi nếu có
      print('Error: $error');
      throw Exception('Failed to send request');
    }
  }
}
