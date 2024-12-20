import 'package:flutter/material.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/selectService_screen.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:frontend/service_screen/service_screen.dart';


class ServiceCartScreen extends StatefulWidget {
  List<Map<String,dynamic>> listpet;
  int sum;
  ServiceCartScreen({required this.listpet,required this.sum});
  @override
  _ServiceCartScreenState createState() => _ServiceCartScreenState();
}

class _ServiceCartScreenState extends State<ServiceCartScreen> {
  // final List<Map<String, dynamic>> pets = [
  //   {
  //     'name': 'Kanlyly',
  //     'type': 'Chó con - 2kg',
  //     'services': ['Tắm, vệ sinh và tỉa lông', 'Khám sức khỏe định kỳ']
  //   },
  //   {
  //     'name': 'Kanlyly',
  //     'type': 'Chó con - 2kg',
  //     'services': ['Tắm, vệ sinh và tỉa lông']
  //   },
  // ];
/////////////////////////////////////////////////////////////////////////////////////////
  // void _navigateToNewOrder() {
  //   /*
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MyServiceScreen(),
        
  //     ),
  //   )
  //   */
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => customerHomePage(selected: 0,)),
  //     (Route<dynamic> route) => false,  // Loại bỏ tất cả các trang trong stack
  //   )
    
  //   .then((newPet) {
  //     if (newPet != null) {
  //       setState(() {
  //         pets.add(newPet);
  //       });
  //     }
  //   });
  // }

  List<Map<String,dynamic>> listpets = [];


  void loadorder() async{
    setState(() {
      listpets = widget.listpet;
      print(listpets);
    });
  }
  @override
  void initState() {
    loadorder();
    super.initState();
  }
  void sendList() async{
    await ServiceAPI.PostService(widget.listpet);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NewOrderScreen(listpet: widget.listpet),
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Popins",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions:
        [
          TextButton(
            onPressed: () {},
            child: Text(
              'Chỉnh sửa',
              style: TextStyle(color: Color(0xFF616165)),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listpets.length,
        itemBuilder: (context, index) {
          final pet =  listpets[index];
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
                children: pet['services']
                    .map<Widget>(
                      (service) => ListTile(
                    title: Text(service),
                  ),
                )
                    .toList(),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.sum.toString(), // Replace with the actual total amount
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity, // Set the desired width here
              child: ElevatedButton(

                /////////////////////////////////////////////////////////////////////////////////////////
                onPressed: sendList,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF49FA4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Order (4)', // Replace with the actual number of selected services
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}