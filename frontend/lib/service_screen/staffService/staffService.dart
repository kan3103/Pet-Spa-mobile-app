import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/staffService/staffServiceDetail.dart';
import 'package:frontend/service_screen/api/getStaffService.dart';
import 'package:frontend/login_screen/login_screen.dart';

class staffService extends StatefulWidget {
  const staffService({super.key});

  @override
  State<staffService> createState() => _staffServiceState();
}

class _staffServiceState extends State<staffService> {
  List<Map<String, dynamic>> orders = [];

  void getAllService() async {
    List<Map<String, dynamic>> listService = await ServiceOrderAPI.getList();
    setState(() {
      orders = listService;
    });
    print(orders);
  }

  @override
  void initState() {
    super.initState();
    getAllService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders.isNotEmpty && orders[0]['orders'] != null
          ? ListView.builder(
        itemCount: orders[0]['orders'].length,
        itemBuilder: (context, index) {
          final dynamic order = orders[0]['orders'][index];
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
                      image: NetworkImage(order['service_image']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                title: Text(order['service'].toString()),
                subtitle: Text(order['status']?.toString() ?? 'Unknown Status'),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffServiceDetail(order: order),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}