import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/homepage/homepage.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:image_picker/image_picker.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  // Controllers để lấy dữ liệu từ các trường nhập
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late String petImage = "";
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
  }
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    
    // Mở thư viện ảnh và chờ người dùng chọn ảnh
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        petImage = image.path; // Cập nhật đường dẫn ảnh vào petImage
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Hàm để lưu thông tin dịch vụ
  void _saveService() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    
    // Kiểm tra và chuyển đổi giá trị price thành int
    int price = int.tryParse(_priceController.text) ?? 0; // Mặc định là 0 nếu không thể chuyển đổi

    // Tại đây bạn có thể lưu giá trị vào database hoặc làm gì đó với dữ liệu
    print('Title: $title, Price: $price, Description: $description',);
    GetService.PostService(title, price, description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Service Name'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                        onTap: _pickImage, // Hàm mở thư viện ảnh
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: petImage.isEmpty
                              ? Center(child: Text('Add Image'))
                              : Image.file(
                            File(petImage), // Hiển thị ảnh từ thư viện
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
              ],
            ),
            SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _saveService,
                            child: Text('Save Service'),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
