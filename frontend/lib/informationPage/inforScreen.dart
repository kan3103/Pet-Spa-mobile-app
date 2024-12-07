import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/informationPage/changeInfor.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final GlobalKey<_InforscreenState> InforscreenKey = GlobalKey<_InforscreenState>();

class Inforscreen extends StatefulWidget {

  final Profile? profile;

  const Inforscreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<Inforscreen> createState() => _InforscreenState();
}
class Pet {
  final String imageUrl;
  final String name;
  final String dob;
  final String petType;
  final bool vaccine;

  Pet({
    required this.imageUrl,
    required this.name,
    required this.dob,
    required this.petType,
    required this.vaccine,
  });
}
class _InforscreenState extends State<Inforscreen> {
  bool isPetSelected = false;
  TextEditingController _nameController = TextEditingController();
  
  String? userName = "John Doe";
  String? userImage = "assets/images/image 1.png"; // Thêm ảnh avatar người dùng
  String petImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.profile != null) {
      setState(() {
        userName = widget.profile!.name;
       //userImage = widget.profile!.avatar; 
      });
    }
  }
  // Danh sách các thú cưng
  List<Pet> pets = [
    Pet(
      imageUrl: 'https://s3-alpha-sig.figma.com/img/3681/5689/c0a30ad311c799c5c10a602d5d708580?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OxBleCST8wO8ssgIfWWh3bHY70EW0ELSb3dH4iwA5o1mcvK3bs~SEX4SKPs~r8GrCiMNHJzv7Qs6y1i04-IqnAnPB~mrcrrBotIyHzV~Ef3FYzsEBBLvtpRF-dJ0dbeVrEQ05keO1FQ4uVZqiNjyDSlsZ1xX3rAjp~GRRFN6wKu7mZqhOWM5SoZi9uJtloCkB-l-AFVzHMuWnhR6qnqXTpqdgKNNp8pE9o50-llF-mYQ9XKus8TCuAP9ShB6ya0PojQVO8YjCWkZWr7mElHGz0Jc4npzd1mWF~R3LKpio1ID0HeNIQ8AzpFqTAgHUDWX0HBu8jdQynM1pPVGnxc9WQ__',
      name: 'Meo Meo',
      dob: '22-11-2022',
      petType: 'Giống: abchd',
      vaccine: true
    ),
    Pet(
      imageUrl: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
      name: 'Kanlyly',
      dob: '22-11-2022',
      petType: 'Giống: abchd',
      vaccine: true
    ),
    // Add more pets as needed
  ];
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
       //userImage = widget.profile!.avatar; 
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    
    // Mở thư viện ảnh và chờ người dùng chọn ảnh
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        petImage = image.path; // Cập nhật đường dẫn ảnh vào petImage
      });
    }
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
  // Thêm thú cưng mới
  void addPet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        TextEditingController petNameController = TextEditingController();
        TextEditingController petDayofBirthController = TextEditingController();
        TextEditingController petTypeController = TextEditingController();
        String petImage = "";
        bool isVaccine = false;

        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                        onTap: _pickImage,
                        child: Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: petImage.isEmpty
                              ? Center(child: Text('Add Image'))
                              : Image.file(
                            File(petImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (petNameController.text.isNotEmpty) {
                            Pet newPet = Pet(
                              imageUrl: petImage,
                              name: petNameController.text,
                              dob: petDayofBirthController.text,
                              petType: petTypeController.text,
                              vaccine: isVaccine,
                            );
                          }
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
        leading: SizedBox(width: 0,),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), // Biểu tượng chỉnh sửa
            onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEditingPage(profile: widget.profile!), 
                    ),
                  );
            }, 
            
            //_editName, // Gọi hàm chỉnh sửa tên khi nhấn

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
            // Phần thông tin thú cưng
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My Pets',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Danh sách các thú cưng
                  GridView.builder(
                    shrinkWrap: true, // Để GridView không chiếm hết không gian
                    //physics: NeverScrollableScrollPhysics(), // Tắt cuộn cho GridView trong SingleChildScrollView
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
                          imageUrl: pets[index].imageUrl?.isEmpty ?? true ? 'assets/images/image 1.png' : pets[index].imageUrl, 
                          name: pets[index].name, 
                          dob: "10kg", 
                          petType: "nothing",
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: addPet,
                child: Text('Add New Pet'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}