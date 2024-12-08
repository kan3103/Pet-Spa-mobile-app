import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/api/getProfile.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/homepage/manager_homepage.dart';
import 'package:frontend/homepage/staff_homepage.dart';
import 'package:frontend/informationPage/inforScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditingPage extends StatefulWidget {
  Profile profile;

  ProfileEditingPage({required this.profile});

  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  late TextEditingController _nameController;
  late TextEditingController _birthdayController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  String accountType = 'customer';
  

  void getType() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       accountType = prefs.getString('account')!;
    });
   
    //print(accountType);
  }
  String? _avatar;
  void loadImg() async{
    if (widget.profile.avatar != null) {
      setState(() {
        _avatar = widget.profile.avatar!;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getType();
    _nameController = TextEditingController(text: widget.profile.name);
    _birthdayController = TextEditingController(text: widget.profile.birthday);
    _addressController = TextEditingController(text: widget.profile.address);
    _emailController = TextEditingController(text: widget.profile.email);
    loadImg();
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _avatar = image.path;
        print(_avatar);
      });
    }
  }
  void prepareScreen() async{
    // InforscreenKey.currentState?.reloadPage();
    print(widget.profile.avatar);
    Profile getprofile = await ProfileAPI.UpdateProfile(widget.profile);
    setState(() {
      widget.profile = getprofile;
    });
   
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa hồ sơ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Avatar chỉnh sửa
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _avatar != null
                      ? FileImage(File(_avatar!))
                      : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  child: _avatar == null
                      ? Icon(Icons.camera_alt, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(height: 16),
              
              // Chỉnh sửa tên
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),

              // Chỉnh sửa ngày sinh
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Ngày sinh',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16),

              // Chỉnh sửa địa chỉ
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 16),

              // Chỉnh sửa email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16),

              // Nút lưu
              ElevatedButton(
                onPressed: () async {
                  // Cập nhật lại profile
                  setState(() {
                    widget.profile.name = _nameController.text;
                    widget.profile.birthday = _birthdayController.text;
                    widget.profile.address = _addressController.text;
                    widget.profile.email = _emailController.text;
                    widget.profile.avatar = _avatar;
                  });
                  
                  
                  prepareScreen();
                  await Future.delayed(Duration(seconds: 1));
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ( accountType == 'customer' ? customerHomePage(selected: 4,) : ( accountType == 'manager' ? managerHomePage(selected: 4) : staffHomePage(selected: 4) )         )  , 
                    ),
                  );
                  // Navigator.pop(context);
                  // // Xử lý lưu hoặc gửi API tại đây
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Hồ sơ đã được lưu!')),
                  // );

                },
                child: Text('Lưu thay đổi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
