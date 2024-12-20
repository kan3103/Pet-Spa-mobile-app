import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/serviceDetail.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:frontend/view_model/itemView_sqr.dart';
import 'package:frontend/view_model/serviceItemView.dart';

class Allservice extends StatefulWidget {
  const Allservice({super.key});

  @override
  State<Allservice> createState() => _AllserviceState();
}

class _AllserviceState extends State<Allservice> {
  List<ServiceItem> services =[] ;
  void loadService() async{
    List<ServiceItem> service = await GetService.GetAllService();
    setState(() {
      services = service;
    });
  }

  @override
  void initState() {
    loadService();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trong lưới
            childAspectRatio: 0.85, // Tỷ lệ chiều cao/chiều rộng cho các item
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 25.0,
          ), 
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Center(
              child:
              /*
              buildBestSellerItem(
                products[index]['imageLink']!,
                products[index]['title']!,
                products[index]['price']!,
                () {
                // Hàm được gọi khi nhấn vào item
                print('Nhấn vào sản phẩm: ${products[index]['title']}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product, cartItemCount: cartItemCount,),
                  ),
                );
                // Hoặc chuyển trang đến trang chi tiết sản phẩm
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: products[index])));
                },
              ),*/
              buildServiceItem(services[index], 
                            () {
                  // Điều hướng đến trang chi tiết khi nhấn vào item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailPage(
                        serviceItem: services[index], 
                      ),
                    ),
                  );
                },"manager",
              ),
            );
          },
        ),
      ),
    );
  }
}