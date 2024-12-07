import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:frontend/view_model/itemView_sqr.dart';

class StaffAllService extends StatefulWidget {
  const StaffAllService({super.key});

  @override
  State<StaffAllService> createState() => _StaffAllServiceState();
}

class _StaffAllServiceState extends State<StaffAllService> {
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
            childAspectRatio: 1, // Tỷ lệ chiều cao/chiều rộng cho các item
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 25.0,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Center(
              child: buildBestSellerItem(
                services[index].image!,
                services[index].name!,
                services[index].price!.toString(),
                    () {
                  // Hàm được gọi khi nhấn vào item
                  print('Nhấn vào sản phẩm: ');

                  // Hoặc chuyển trang đến trang chi tiết sản phẩm
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: products[index])));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}