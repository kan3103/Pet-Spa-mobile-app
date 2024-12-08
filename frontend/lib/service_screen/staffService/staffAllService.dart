import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:frontend/service_screen/staffService/staffServiceDetail.dart';
import 'package:frontend/view_model/itemView_sqr.dart';
import 'package:frontend/service_screen/api/getStaffService.dart';

class StaffAllService extends StatefulWidget {
  const StaffAllService({super.key});

  @override
  State<StaffAllService> createState() => _StaffAllServiceState();
}

class _StaffAllServiceState extends State<StaffAllService> {
  List<Map<String, dynamic>> orders = [];

  void getAllService() async {
    List<Map<String, dynamic>> listService = await ServiceOrderAPI.getList();
    setState(() {
      orders = listService;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GridView.builder(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2, // Số cột trong lưới
      //       childAspectRatio: 1, // Tỷ lệ chiều cao/chiều rộng cho các item
      //       crossAxisSpacing: 10.0,
      //       mainAxisSpacing: 25.0,
      //     ),
      //     itemCount: orders[0]['orders'].length,
      //     itemBuilder: (context, index) {
      //       final dynamic order = orders[0]['orders'][index];
      //       return Center(
      //         child: buildBestSellerItem(
      //           order['image'].toString(),
      //           order['service_id'].toString(),
      //           order['status'].toString(), // replace
      //               () {
      //             // Hàm được gọi khi nhấn vào item
      //             // Hoặc chuyển trang đến trang chi tiết sản phẩm
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => StaffServiceDetail(order: order)));
      //           },
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body:
      ListView.builder(
          itemCount: orders[0]['orders'].length,
          itemBuilder: (context, index) {
            final dynamic order = orders[0]['orders'][index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Card(
                color: Color(0xFFF49FA4),
                elevation: 4,
                child: ExpansionTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/serviceScreen/pet_2.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  title: Text(order['service_id'].toString()),
                  subtitle: Text(order['status'].toString()),
                ),

              ),
            );
          }
      ),
    );
  }
}
