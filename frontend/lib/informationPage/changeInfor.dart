import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/api/getProfile.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/informationPage/inforScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditingPage extends StatefulWidget {
  final Profile profile;

  ProfileEditingPage({required this.profile});

  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  late TextEditingController _nameController;
  late TextEditingController _birthdayController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  File? _avatar;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _birthdayController = TextEditingController(text: widget.profile.birthday);
    _addressController = TextEditingController(text: widget.profile.address);
    _emailController = TextEditingController(text: widget.profile.email);
    if (widget.profile.avatar != null) {
      _avatar = File(widget.profile.avatar!);
    }
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    }
  }
  void prepareScreen() async{
    // InforscreenKey.currentState?.reloadPage();
    await ProfileAPI.UpdateProfile(widget.profile);
    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => customerHomePage(selected: 4,), 
                    ),
                  );
    
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
                      ? FileImage(_avatar!) 
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
                onPressed: () {
                  // Cập nhật lại profile
                  widget.profile.name = _nameController.text;
                  widget.profile.birthday = _birthdayController.text;
                  widget.profile.address = _addressController.text;
                  widget.profile.email = _emailController.text;
                  widget.profile.avatar = _avatar?.path;
                  
                  prepareScreen();
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
