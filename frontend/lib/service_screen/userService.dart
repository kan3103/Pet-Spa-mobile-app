import 'package:flutter/material.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';

class userService extends StatefulWidget {
  const userService({super.key});

  @override
  State<userService> createState() => _userServiceState();
}

class _userServiceState extends State<userService> {

  final List<Map<String, dynamic>> pets = [
    {
      'name': 'Kanlyly',
      'type': 'Chó con - 2kg',
      'services': ['Tắm, vệ sinh và tỉa lông', 'Khám sức khỏe định kỳ']
    },
    {
      'name': 'Kanlyly',
      'type': 'Chó con - 2kg',
      'services': ['Tắm, vệ sinh và tỉa lông']
    },
  ];

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewOrderScreen(), 
                    ),
          );
          /*
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewOrderScreen()),
          );*/
        }, 
        
        label: const Text('Đơn mới', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF49FA4),
        icon: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}