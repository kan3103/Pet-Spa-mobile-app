import 'package:flutter/material.dart';
import 'package:frontend/class_model/models/Staff.dart';
import 'package:frontend/class_model/models/seeAll.dart';
import 'package:frontend/class_model/orderItem.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/informationPage/changeInfor.dart';
import 'package:frontend/login_screen/login_screen.dart';

class Managerprofile extends StatefulWidget {
  
  final Profile profile;
  const Managerprofile({super.key , required this.profile });
  @override
  State<Managerprofile> createState() => _ManagerprofileState();
}

class _ManagerprofileState extends State<Managerprofile> {
  String? userName = "John Doe";
  String? userImage = "assets/images/image 1.png";
  bool isload = true;
  
  List<Staff>? staffs;

  void getService() async{
    List<Staff> listSTaff = await AllServiceAPI.getStaffnow();
    print(listSTaff);
    setState(() {
      staffs = listSTaff;
      isload = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getService();
    super.initState();
    if (widget.profile != null) {
      setState(() {
        userName = widget.profile!.name;
       //userImage = widget.profile!.avatar; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        leading: IconButton(
          icon: Icon(Icons.edit), // Biểu tượng chỉnh sửa
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditingPage(profile: widget.profile!),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // SignOut icon
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(userImage!),
                  ),
                  SizedBox(width: 20),
                  Text(
                    userName!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Căn đều các nút
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text('Xem thông tin', style:  TextStyle( fontWeight: FontWeight.bold , fontSize: 20 ),),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => seeDetailAll(list: staffs),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20,),
                              Icon(Icons.person),
                              SizedBox(width: 30,) ,
                              Text('Xem thông tin nhân viên',),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward),
                              SizedBox(width: 20,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                 // SizedBox(height: 80,),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Xử lý sự kiện khi nút "Xem thông tin" được bấm
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20,),
                              Icon(Icons.person),
                              SizedBox(width: 30,) ,
                              Text('Xem thông tin khách hàng',),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward),
                              SizedBox(width: 20,),
                            ],
                          ),
                        ],
                      ),
                    ),
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