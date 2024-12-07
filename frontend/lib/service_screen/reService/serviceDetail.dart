import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/editService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetailPage extends StatefulWidget {
  ServiceItem serviceItem;

  // Constructor nhận các thông tin sản phẩm
  ServiceDetailPage({
    required this.serviceItem,
  });

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
 String accountType = 'customer';
   void getType() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       accountType = prefs.getString('account')!;
    });
   
    //print(accountType);
  }
  @override
  void initState() {
    // TODO: implement initState
    getType();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFF49FA4),

        actions: [
          accountType=="manager"?IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  // Mở popup chỉnh sửa khi nhấn nút sửa
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditServicePage(serviceItem: widget.serviceItem),
                  ),
                );
                },
              ):SizedBox(width: 0,),
              accountType=="manager"?IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  // Xử lý hành động xóa

                },
              ):SizedBox(width: 0,),
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
                widget.serviceItem.image!,
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
                    widget.serviceItem.name!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  
                  // Mô tả sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.serviceItem.description!,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Giá sản phẩm
                  Text(
                    widget.serviceItem.price!.toString(),
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
