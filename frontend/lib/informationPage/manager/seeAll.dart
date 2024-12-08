import 'package:flutter/material.dart';
import 'package:frontend/informationPage/manager/seeDetailProfile.dart';


class seeDetailAll extends StatefulWidget {
  final bool isStaff ;
  final List<dynamic>? list;
  const seeDetailAll({super.key, required this.list, required this.isStaff});
  @override
  State<seeDetailAll> createState() => _seeDetailAllState();
}

class _seeDetailAllState extends State<seeDetailAll> {

  List<dynamic>? lists;
  
  @override
  void initState() {
    // TODO: implement initState
    lists = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách'),
      ),
      body: ListView.builder(
        
        itemCount: lists!.length,
        itemBuilder: (context, index) {
          //final staff = lists[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: lists![index].image == null ?Text(lists![index].username![0].toUpperCase()):Image.network(lists![index].image), // Chữ cái đầu tiên của username
              ),
              title: Text(lists![index].username ?? 'Không có tên'),
              subtitle: Text(lists![index].email ?? 'Không có email'),
              trailing: Icon(Icons.arrow_forward) ,
              onTap: () {
                // Xử lý khi nhấn vào từng staff (có thể mở trang chi tiết)
                widget.isStaff ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Đang xem thông tin ${lists![index].username}'),
                ))
                :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>  Seedetailprofile(id_user: lists![index].id ) )
                  )
                ;
              },
            ),
          );
        },
      ),
    );
  }
}