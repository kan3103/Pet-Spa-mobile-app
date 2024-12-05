import 'package:flutter/material.dart';
import 'package:frontend/class_model/orderItem.dart';
import 'package:frontend/service_screen/api/getService.dart';

class OrderManager extends StatefulWidget {
  const OrderManager({super.key});

  @override
  State<OrderManager> createState() => _OrderManagerState();
}

class _OrderManagerState extends State<OrderManager> {

  List<Map<String, dynamic>> pets = [];

  void getService() async{
    List<Map<String,dynamic>> listService = await AllServiceAPI.getList();
    setState(() {
      pets = listService;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getService();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
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
                subtitle: Text(pet['type']),
                children: pet['orders']
                    .map<Widget>(
                      (service) => ListTile(
                    title: Text(service['service']),
                  ),
                )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}