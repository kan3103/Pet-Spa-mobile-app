import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/editService.dart';
import 'package:frontend/view_model/itemView_sqr.dart';
import 'package:shared_preferences/shared_preferences.dart';


Widget buildServiceItem(

    ServiceItem service_item, VoidCallback onPressed, String accountType) {
    
  return GestureDetector(
    onTap: accountType=="manager"?onPressed:null, // Hàm sẽ được gọi khi nhấn vào item
    child: Container(
      width: 146,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFF49FA4),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: getImageWidget(service_item.image!, 130, 146), // Hàm này trả về widget hiển thị ảnh
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              service_item.name!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              service_item.price!.toString(),
              style: TextStyle(color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              service_item.description!,
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis, // Giới hạn hiển thị nếu quá dài
            ),
          ),
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Mở popup chỉnh sửa khi nhấn nút sửa
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditServicePage(serviceItem: service_item),
                  ),
                );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Xử lý hành động xóa

                },
              ),
            ],
          )*/
        ],
      ),
    ),
  );
}

// Hàm để hiển thị popup sửa
void _showEditDialog(BuildContext context, String title, String price, String description) {
  final titleController = TextEditingController(text: title);
  final priceController = TextEditingController(text: price);
  final descriptionController = TextEditingController(text: description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Sửa thông tin dịch vụ'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Hoàn thành chỉnh sửa và cập nhật
              String newTitle = titleController.text;
              String newPrice = priceController.text;
              String newDescription = descriptionController.text;
              // Thực hiện cập nhật tại đây (ví dụ: gọi API hoặc cập nhật state)
              Navigator.pop(context);
            },
            child: Text('Hoàn thành'),
          ),
        ],
      );
    },
  );
}

// Hàm để hiển thị popup xóa
void _showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa dịch vụ này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Xử lý xóa tại đây
            },
            child: Text('Xóa'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
        ],
      );
    },
  );
}
