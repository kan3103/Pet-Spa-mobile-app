import 'package:flutter/material.dart';
import 'package:frontend/service_screen/selectService_screen.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:frontend/service_screen/service_screen.dart';


class ServiceCartScreen extends StatefulWidget {
  @override
  _ServiceCartScreenState createState() => _ServiceCartScreenState();
}

class _ServiceCartScreenState extends State<ServiceCartScreen> {
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

  void _navigateToNewOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyServiceScreen()),
    ).then((newPet) {
      if (newPet != null) {
        setState(() {
          pets.add(newPet);
        });
      }
    });
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  SelectServiceScreen()),
            );
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
                  '555.000', // Replace with the actual total amount
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
                onPressed: _navigateToNewOrder,
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