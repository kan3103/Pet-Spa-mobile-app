import 'package:flutter/material.dart';
import 'package:frontend/class_model/models/Staff.dart';
import 'package:frontend/class_model/orderItem.dart';

class BottomSheetPopup extends StatelessWidget {
  final List<Staff> ids;  // Danh sách các ID sẽ được truyền vào
  final int orderId ;
  //final Function(int) onIDSelected; // Callback để trả về ID

  //IDPopup({required this.ids, required this.onIDSelected});
  BottomSheetPopup({required this.ids , required this.orderId});

  void putStaff(int id, int service) async{
    await AllServiceAPI.PutStaff(id, service);

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Danh sách ID', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ids.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ID: ${ids[index].username}'),
                  onTap: () {
                    // Có thể thêm hành động khi người dùng chọn vào ID.
                    print('Bạn chọn ID: ${ids[index].id}');
                    putStaff( ids[index].id! ,orderId);
                    //onIDSelected(ids[index].id!); // Trả về ID khi nhấn
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}