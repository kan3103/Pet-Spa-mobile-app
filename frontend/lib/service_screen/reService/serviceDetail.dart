import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/editService.dart';

class ServiceDetailPage extends StatelessWidget {
  ServiceItem serviceItem;

  // Constructor nhận các thông tin sản phẩm
  ServiceDetailPage({
    required this.serviceItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFF49FA4),

        actions: [
          IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  // Mở popup chỉnh sửa khi nhấn nút sửa
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditServicePage(serviceItem: serviceItem),
                  ),
                );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  // Xử lý hành động xóa

                },
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hiển thị ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                serviceItem.image!,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  
                  // Tiêu đề sản phẩm
                  Text(
                    serviceItem.name!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  
                  // Mô tả sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      serviceItem.description!,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Giá sản phẩm
                  Text(
                    serviceItem.price!.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
