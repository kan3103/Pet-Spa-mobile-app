import 'package:flutter/material.dart';
import 'package:frontend/login_screen/login_screen.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/models/listService.dart';
import 'package:frontend/service_screen/staffService/staffService.dart';
import 'package:frontend/service_screen/staffService/staffServiceDetail.dart';
import 'package:frontend/service_screen/api/getService.dart';

class staffService extends StatefulWidget {
  const staffService({super.key});

  @override
  State<staffService> createState() => _staffServiceState();
}

class _staffServiceState extends State<staffService> {

  // List<Map<String, dynamic>> pets = [];
  //
  // void getService() async{
  //   List<Map<String,dynamic>> listService = await ServiceAPI.getList();
  //   setState(() {
  //     pets = listService;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getService();
  //   super.initState();
  // }

  List<Map<String, dynamic>> pets = [
    {
      'name': 'Bath',
      'status': 'In Progress',
      'price': 12500,
      'pet': [
        {'name': 'Khang'},
        {'type': 'Cat'},
        {'note': 'None'},
      ],
    },
    {
      'name': 'Spa',
      'status': 'Completed',
      'price': 12500,
      'pet': [
        {'name': 'Bach'},
        {'type': 'Dog'},
        {'note': 'Dangerous'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              color: Color(0xFFF49FA4),
              elevation: 4,
              child: ListTile(
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
                subtitle: Text(pet['status']),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => StaffServiceDetail(pet: pet, cartItemCount: cartItemCount),
      //       ),
      //     );
      //     /*
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => NewOrderScreen()),
      //     );*/
      //   },
      //
      //   label: const Text('Đơn mới', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
      //   backgroundColor: Color(0xFFF49FA4),
      //   icon: Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}