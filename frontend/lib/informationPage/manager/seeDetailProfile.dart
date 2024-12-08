import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/api/getProfile.dart';

class Seedetailprofile extends StatefulWidget {
  final int id_user ; 
  const Seedetailprofile({super.key, required this.id_user});

  @override
  State<Seedetailprofile> createState() => _SeedetailprofileState();
}

class _SeedetailprofileState extends State<Seedetailprofile> {

  Profile? user ;  
  bool isload = true; 
  void getMyProfile() async{
    Profile? getuser = await ProfileAPI.getUserProfile(widget.id_user.toString());
    setState(() {
      isload = false;
      user = getuser ; 
    }); 
  }

  @override
  void initState() {
    // TODO: implement initState
    getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Information'),
        backgroundColor: Color(0xFFF49FA4),
      ),
      body: isload ?
      const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )): Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar section
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user!.avatar ?? "assets/images/image 1.png"),
              ),
            ),
            SizedBox(height: 20),

            // Name section
            Text(
              user!.name ?? 'N/A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            // Birthday section
            Text(
              'Birthday: ${user!.birthday ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),

            // Address section
            Text(
              'Address: ${user!.address ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),

            // Email section
            Text(
              'Email: ${user!.email ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}