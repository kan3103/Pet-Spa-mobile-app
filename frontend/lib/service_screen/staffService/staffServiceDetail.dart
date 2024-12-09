import 'package:flutter/material.dart';
import 'package:frontend/class_model/orderItem.dart';
import 'package:frontend/homepage/staff_homepage.dart';
import 'package:frontend/informationPage/api/petApi.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/models/Pet.dart';

class StaffServiceDetail extends StatefulWidget {
  final dynamic order;

  const StaffServiceDetail({Key? key, required this.order}) : super(key: key);

  @override
  _StaffServiceDetailState createState() => _StaffServiceDetailState();
}

class _StaffServiceDetailState extends State<StaffServiceDetail> {
  bool loadPet = true;
  Pet? pet ;
  Map<String, dynamic>? selectedPet;

  Future<void> getService() async {
    pet = await PetAPI.getPetdetail(widget.order['pet_id'].toString());
    setState(() {
      loadPet = false;
    });
  }
  Future<void> updateOrder(int service) async{
    await AllServiceAPI.PutDoneOrder(service);
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
      body: loadPet? 
      const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      ))
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 320,
              width: MediaQuery.of(context).size.width,
              // replace by widget.order['image'] when available
              child: Image.network(
                widget.order['service_image'],
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
                      image: DecorationImage(
                        image: NetworkImage(pet!.image.toString()),
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
                        'Tên thú cưng: ${widget.order['pet']}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: (){
              updateOrder(widget.order['id']);
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => staffHomePage(selected: 1),));
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check),
                const Text('Hoàn thành'),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
