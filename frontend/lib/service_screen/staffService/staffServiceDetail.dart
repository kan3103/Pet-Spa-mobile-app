import 'package:flutter/material.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/models/Pet.dart';

class StaffServiceDetail extends StatefulWidget {
  final dynamic order;

  const StaffServiceDetail({Key? key, required this.order}) : super(key: key);

  @override
  _StaffServiceDetailState createState() => _StaffServiceDetailState();
}

class _StaffServiceDetailState extends State<StaffServiceDetail> {
  List<Map<String, dynamic>> pets = [];
  Map<String, dynamic>? selectedPet;

  Future<void> getService() async {
      List<Map<String, dynamic>> listService = await ServiceAPI.getList();
      setState(() {
        pets = listService;
      });
  }

  @override
  void initState() {
    super.initState();
    getService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFF49FA4),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 320,
              width: MediaQuery.of(context).size.width,
              // replace by widget.order['image'] when available
              child: Image.network(
                "https://via.placeholder.com/600x320.png?text=Pet+Spa",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text("Failed to load image"));
                },
              ),
            ),
            const SizedBox(height: 16),

            // Service ID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Dịch vụ: ${widget.order['service_id']}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Order Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Trạng thái: ${widget.order['status']}',
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),

            // Pet Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Pet Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/serviceScreen/pet_2.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Pet Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên thú cưng: ${widget.order['pet_id']}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
