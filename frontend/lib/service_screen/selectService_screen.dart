import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';

import 'package:frontend/service_screen/models/Pet.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:frontend/service_screen/serviceCart.dart';



class SelectServiceScreen extends StatefulWidget {

  final List<Pet> pets;
  int check;
  List<Map<String,dynamic>> listpet;
  int sum;
  SelectServiceScreen({required this.check, required this.pets,required this.listpet,required this.sum});
  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool isServiceSelected = false;
  List<ServiceItem> services =[] ;
  Map<String,dynamic> pet = {};
  List<String> listpets = [];
  int checks=0;
  /*
  = [
    ServiceItem(
      imageLink: 'https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HedJBnbEpvN2kis0akNSBYAhlPv5ijVMwLFL3FoFNHnUiMpN4IEKOhfqkLJZAwG3KONImVnA44Q76AZzInFuU9PUrJokA3F55rcrU0mZX6Ib6in0IzDGbv42bNJMNkADyPLo~9akE4DZIxMGOm0iUAKwOlAFxDPNdETjFBXYxt-7AX1-RYFlnz230vGkHN2aBW3h0lunmR4-QKqOe1PIAqp55VK0lmbiCUdn-N9cQAoeRvXzMvLLN9vEzJzfHJGMn8aJHe9ZE796zglNPwADRVazIZM~3UmJYHUNA-~mkGKhLe1av5uhIo7x8zFVr5o7tXF98FzeARZvx~E7B6oY1A__',
      title: 'Combo: dịch vụ tắm, vệ sinh và tỉa lông',
      price: 'đ 12.500',
      description: ''
    ),
    ServiceItem(
      image: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
      title: 'Pate cho mèo Whiskas 80g hương Cá Biển',
      price: 'đ 12.500',
      description: ''
    ),
  ];
  */
  String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}
  void _onPetSelected(bool selected, String title, int id,int price) {

    listpets.add(title);
    if(selected)
    widget.sum+=price;
    else widget.sum-=price;
    setState(() {
      isServiceSelected = selected;
      pet = {
        'name': widget.pets[widget.check].name,
        'services':listpets,
      };
    });
  }
 void loadService() async{
    List<ServiceItem> service = await GetService.GetAllService();
    setState(() {
      services = service;
    });
  }

  @override
  void initState() {
    checks = widget.check;
    loadService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn dịch vụ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Popins",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {/*
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewOrderScreen()),
            );*/
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceCard
                  (
                    id: service.id!,
                    imageLink: service.image!,
                    title: service.name!,
                    price: service.price!.toString(),
                    onSelected: _onPetSelected,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            width: double.infinity,
            child: widget.check==widget.pets.length-1? ElevatedButton(
              onPressed: () {
                widget.listpet.add(pet);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceCartScreen(listpet: widget.listpet,sum: widget.sum,)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isServiceSelected ? Color(0xFFF49FA4) : Colors.grey.shade400,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Tạo đơn',
                style: TextStyle(color: Colors.white),
              ),
            ):ElevatedButton(
              onPressed: () {
                
                if(widget.check<checks){
                  widget.listpet.removeAt(widget.listpet.length-1);
                  widget.listpet.add(pet);
                }
                else{
                  widget.listpet.add(pet);
                  checks++;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectServiceScreen(pets: widget.pets,check: checks,listpet: widget.listpet,sum: widget.sum,)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isServiceSelected ? Color(0xFFF49FA4) : Colors.grey.shade400,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Tiếp theo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ServiceCard extends StatefulWidget {
  final String imageLink;
  final String title;
  final String price;
  final int id;
  final Function(bool,String,int,int) onSelected;

  const ServiceCard({
    Key? key,
    required this.imageLink,
    required this.title,
    required this.price,
    required this.onSelected,
    required this.id,
  }) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      widget.onSelected(isSelected,widget.title,widget.id,int.parse(widget.price));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink.shade100 : Colors.pink.shade50,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    widget.imageLink,
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  _toggleSelection();
                },
                shape: const CircleBorder(),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}