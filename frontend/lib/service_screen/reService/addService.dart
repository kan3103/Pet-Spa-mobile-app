import 'package:flutter/material.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  // Controllers để lấy dữ liệu từ các trường nhập
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
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
    print('Title: $title, Price: $price, Description: $description');
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
            ElevatedButton(
              onPressed: _saveService,
              child: Text('Save Service'),
            ),
          ],
        ),
      ),
    );
  }
}
