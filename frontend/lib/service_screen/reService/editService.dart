import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';

class EditServicePage extends StatefulWidget {
  final ServiceItem serviceItem;

  EditServicePage({required this.serviceItem});

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  // Controller để lấy dữ liệu từ các trường chỉnh sửa
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controllers với dữ liệu ban đầu từ serviceItem
    _titleController = TextEditingController(text: widget.serviceItem.name);
    _priceController = TextEditingController(text: widget.serviceItem.price.toString() );
    _descriptionController = TextEditingController(text: widget.serviceItem.description);
  }

  @override
  void dispose() {
    // Dọn dẹp controllers khi không sử dụng nữa
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa dịch vụ"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Lưu và quay lại trang trước khi nhấn nút Save
              
              Navigator.pop(context); // Trả về item đã chỉnh sửa
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh dịch vụ
            Image.network(widget.serviceItem.image!, height: 300, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16),

            // Tiêu đề
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Tiêu đề',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Giá
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Giá',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Mô tả
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
              ),
              maxLines: 5, // Cho phép nhập nhiều dòng
            ),
          ],
        ),
      ),
    );
  }
}
