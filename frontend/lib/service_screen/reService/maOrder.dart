//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:frontend/class_model/models/Staff.dart';
import 'package:frontend/class_model/orderItem.dart';
import 'package:frontend/homepage/manager_homepage.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/reService/addStafforservice.dart';

class OrderManager extends StatefulWidget {
  const OrderManager({super.key});

  @override
  State<OrderManager> createState() => _OrderManagerState();
}

class _OrderManagerState extends State<OrderManager> {
  bool isload = true;
  List<Map<String, dynamic>>? pets ;
  List<Staff>? staffs;
  //List<List<TextEditingController>> staffControllers = [];

  void _showBottomSheet( List<Staff>? list  ) {
    // Danh sách ID mẫu
    List<Staff> ids = list!;

    // Hiển thị Bottom Sheet
    
  }
  void handleIDSelection(int id, int selectedID) {
    print('ID đã chọn: $selectedID');

    // Bạn có thể thực hiện thêm các hành động khác với ID đã chọn
  }
  
  @override
  void initState() {
    getService();
    super.initState();

    // Khởi tạo các controller cho mỗi pet và mỗi order
  }
  void putStaff(int id, int service) async{
    await AllServiceAPI.PutStaff(id, service);
    print("oke");
  }
  /*
  @override
  void dispose() {
    // Giải phóng các controller khi không sử dụng nữa
    for (var petControllers in staffControllers) {
      for (var controller in petControllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }*/
  void getService() async{
    List<Map<String,dynamic>> listService = await AllServiceAPI.getList();
    List<Staff> listSTaff = await AllServiceAPI.getStaffnow();
    print(listService);
    setState(() {
      pets = listService;
      staffs = listSTaff;
      isload = false;
    });
    
    print(pets!.length);
  }
  /*
  @override
  void initState() {
    // TODO: implement initState
    getService();
    super.initState();
    //print(pets);
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isload?
      const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )):
      ListView.builder(
        itemCount: pets?.length,
        itemBuilder: (context, index) {
          final pet = pets![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              color: Color(0xFFF49FA4),
              elevation: 4,
              child: ExpansionTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/serviceScreen/pet_2.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                title: Text(pet['name']),
                subtitle: Text(pet.length.toString()),
                children: [
                /*
                GridView.builder(
                  
                  gridDelegate: gridDelegate, 
                  itemBuilder: itemBuilder
                ),*/

                ListView.builder(
                  shrinkWrap: true, // Cho phép ListView nhỏ lại trong ExpansionTile
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: pet['orders']!.length,
                  itemBuilder: (context, orderindex){
                    final order = pet['orders']![orderindex];
                    //print(order);
                    TextEditingController controller = //staffControllers[index][orderindex] ?? 
                      TextEditingController();
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      elevation: 2,
                      color: Colors.white,
                      child: ListTile(
                        // title: 
                        subtitle: Row(
                          children: [
                            Column(
                              children: [
                                Text("Staff:${order['staff_id']==null?"Chưa có":order['staff_id']}"),
                                Text('Service: ${order['service_id'] }'),
                                Text('Pet Name: ${order['pet_id'] }'),
                              ],
                            ),
                          ],
                        ),
                        //leading: Icon(Icons.shopping_cart),
                        //////////////////////////////////////////////////
                        
                        trailing: FloatingActionButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheetPopup(ids: staffs! , orderId: order['id'],  );
                              },
                            );
                          } 
                          ),
                        /*
                        Container(
                            width: 150,
                            child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number, // Chỉ cho phép nhập số
                              decoration: InputDecoration(
                                labelText: 'Staff ID',
                                border: OutlineInputBorder(),
                              ),
                              /*
                                 onEditingComplete:() {
                                  print(controller.text);
                                  putStaff(int.parse(controller.text),order['id']);
                                }*/
                                onSubmitted: (text) {
                                  print(text);
                                  putStaff(int.parse(text),order['id']);
                                  controller.clear();
                                  // Navigator.pushReplacement(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) => managerHomePage(selected: 1), 
                                  //           ),
                                  // );
                                },
                            ),
                        ),*/
                        //////////////////////////////////////////////////  
                      ), 
                    );
                    
                    }
                  
                ),
                
                ],
              ),
            ),
            
              
          );
        },
      ),
    );
  }
}