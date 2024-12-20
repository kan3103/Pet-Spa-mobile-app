import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/informationPage/api/petApi.dart';
import 'package:frontend/informationPage/changeInfor.dart';
import 'package:frontend/service_screen/models/Pet.dart';
import 'package:frontend/service_screen/models/petCard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/login_screen/login_screen.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<_InforscreenState> InforscreenKey = GlobalKey<_InforscreenState>();

class Inforscreen extends StatefulWidget {

  final Profile? profile;

  const Inforscreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<Inforscreen> createState() => _InforscreenState();
}
// class Pet {
//   final String imageUrl;
//   final String name;
//   final String dob;
//   final String petType;
//   final bool vaccine;

//   Pet({
//     required this.imageUrl,
//     required this.name,
//     required this.dob,
//     required this.petType,
//     required this.vaccine,
//   });
// }


class _InforscreenState extends State<Inforscreen> {
  bool isPetSelected = false;
  bool loadPet = true;
  TextEditingController _nameController = TextEditingController();
  String accountType = 'staff';
  String? userName = "John Doe";
  String? userImage = ""; // Thêm ảnh avatar người dùng
  String? birthday = "John Doe";
  String? address = "John Doe";
  String petImage = "";
  String petimage = "";

  void getPets () async {
    List<Pet> pet = await PetAPI.getPet();
    setState(() {
      pets = pet;
      loadPet = false;
    });
  }

  void getaccType() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accountType = prefs.getString('account')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPets();
    getaccType();
    super.initState();
    if (widget.profile != null) {
      setState(() {
        userName = widget.profile!.name;
        birthday = widget.profile!.birthday ==null ? '' :widget.profile!.birthday  ;
        address = widget.profile!.address == null ? '' : widget.profile!.address;
       userImage = widget.profile!.avatar; 
      });
    }
  }
  // Danh sách các thú cưng
  List<Pet> pets = [];
  void _onPetSelected(bool selected) {
    setState(() {
      isPetSelected = selected;
    });
  }
  @override
  void reloadPage(){
    if (widget.profile != null) {
      setState(() {
        userName = widget.profile!.name;
        birthday = widget.profile!.birthday;
        address = widget.profile!.address;
       //userImage = widget.profile!.avatar; 
      });
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Khoảng cách giữa các hàng
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600, // In đậm nhãn
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87, // Màu chữ chính
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _editName() {
    // Gán giá trị hiện tại của tên vào controller
    _nameController.text = userName! ;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Cập nhật tên người dùng
                setState(() {
                  userName = _nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại nếu hủy
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
bool isVaccine = false;

void addPet() {
  TextEditingController petNameController = TextEditingController();
  TextEditingController petDayofBirthController = TextEditingController();
  TextEditingController petTypeController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Thêm thú cưng mới',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: petNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: petDayofBirthController,
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: isVaccine,
                          onChanged: (value) {
                            setState(() {
                              isVaccine = value!;
                            });
                          },
                        ),
                        Text('Đã tiêm Vắc-xin'),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: petTypeController,
                      decoration: InputDecoration(
                        labelText: 'Loại thú cưng',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          petimage = image!.path;
                        });
                        print(petimage);
                      },
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: petimage==''
                            ? Center(child: Text('Add Image'))
                            : Image.file(
                                File(petimage),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (petNameController.text.isNotEmpty) {
                          Pet newPet = Pet(
                            image: petimage,
                            name: petNameController.text,
                            dob: petDayofBirthController.text,
                            petType: int.parse(petTypeController.text),
                            vaccinated: isVaccine,
                          );
                          PetAPI.addPet(newPet);
                        }
                        
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => customerHomePage(selected: 4,)));
                      },
                      child: Text('Lưu thú cưng'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
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
          children: <Widget>[
            // Phần thông tin người dùng (Ảnh và Tên)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userImage!=""?NetworkImage(userImage!):AssetImage("assets/images/image 1.png"),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userName!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(7.0), // Thêm padding đồng đều
              child: Card(
                elevation: 4, // Hiệu ứng nổi để tạo sự tách biệt
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bo góc card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding bên trong card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 99, 4, 4), // Tô màu tiêu đề
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade300), // Dòng phân cách
                      SizedBox(height: 10),
                      _buildInfoRow('Họ và tên:', widget.profile?.name ?? 'N/A'),
                      _buildInfoRow('Ngày sinh:', widget.profile?.birthday ?? 'N/A'),
                      _buildInfoRow('Địa chỉ:', widget.profile?.address ?? 'N/A'),
                      _buildInfoRow('Email:', widget.profile?.email ?? 'N/A'),
                    ],
                  ),
                ),
              ),
            ),

// Helper widget to format information rows
          Divider(),
            // Phần thông tin thú cưng
            ////////////////////////////////////////////////////
            ///
            ///
            ///
            ///
            accountType=='staff' ? SizedBox(width: 0,) : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Pets',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isPetSelected?Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ElevatedButton(
                              onPressed: addPet,
                              child: Text('Delete Pet'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                backgroundColor: Color(0xFFF49FA4), 
                                foregroundColor: Colors.white, 
                              ),
                            ),
                          ),Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ElevatedButton(
                              onPressed: addPet,
                              child: Text('Chỉnh Pet'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                backgroundColor: Color(0xFFF49FA4), 
                                foregroundColor: Colors.white, 
                              ),
                            ),
                          ),
                        ],
                      ):Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: addPet,
                          child: Text('Add New Pet'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            backgroundColor: Color(0xFFF49FA4), 
                            foregroundColor: Colors.white, 
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Danh sách các thú cưng
                  this.loadPet?const Center(
                    child: SizedBox(        
                      width: 30, 
                      height: 30, 
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0, 
                      ),
                  )):GridView.builder(
                    shrinkWrap: true, // Để GridView không chiếm hết không gian
                    physics: NeverScrollableScrollPhysics(), // Tắt cuộn cho GridView trong SingleChildScrollView
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Xử lý khi nhấn vào thú cưng, có thể thêm vào hành động chi tiết ở đây
                          print("Tapped on ${pets[index].name}");
                        },
                        child: PetCard(
                          imageUrl: pets[index].image?.isEmpty ?? true ? 'assets/images/image 1.png' : pets[index].image!, 
                          name: pets[index].name!, 
                          dob: pets[index].dob ?? '', 
                          petType: PetAPI.PetType(pets[index].petType!),
                          onSelected: _onPetSelected,
                        ),
                        /*Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              
                              Image.asset(
                                pets[index]["image"]?.isEmpty ?? true ? 'assets/images/image 1.png' : pets[index]["image"]!,
                                //width: 100,
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Text(
                                pets[index]["name"]!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),*/
                      );
                    },
                  ),
                ],
              ),
            ),
            // Nút thêm thú cưng
            
          ],
        ),
      ),
    );
  }
}