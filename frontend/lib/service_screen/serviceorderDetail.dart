import 'package:flutter/material.dart';
import 'package:frontend/class_model/orderServiceDetail.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/reService/editService.dart';

class orderServiceDetailPage extends StatefulWidget {
  
  final int id;
  // Constructor nhận các thông tin sản phẩm
  orderServiceDetailPage({
    super.key,
    required this.id
  });

  @override
  State<orderServiceDetailPage> createState() => _orderServiceDetailPageState();
}

class _orderServiceDetailPageState extends State<orderServiceDetailPage> {

  orderServiceDetail? item;
  void Loaditem() async{
    orderServiceDetail getitem = await ServiceAPI.getorderdetail(widget.id.toString());
    setState(() {
      item = getitem;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    Loaditem();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFF49FA4),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hiển thị ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item!.image!,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(children: [
                    Text(
                      'Thông tin dịch vụ: ',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    
                  ],),
                  // Tiêu đề sản phẩm
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                          "Order ID: ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item!.id.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "Service: ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      Text(
                        item!.service!,
                        style: TextStyle(fontSize: 20,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Text(
                    item!.pet!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    item!.status==1?"Đang thực hiện":"N/A",
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 139, 24, 11), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // Mô tả sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      item!.description!,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                  
                  // Giá sản phẩm
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
