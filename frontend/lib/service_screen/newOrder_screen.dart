import 'package:flutter/material.dart';
import 'package:frontend/service_screen/api/getService.dart';
import 'package:frontend/service_screen/models/Pet.dart';
import 'package:frontend/service_screen/service_screen.dart';
import 'package:frontend/service_screen/selectService_screen.dart';
import 'package:frontend/view_model/itemView_sqr.dart';

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



class NewOrderScreen extends StatefulWidget {
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  bool isPetSelected = false;

  // final List<Pet> pets = [
  //   Pet(
  //     imageUrl: 'https://s3-alpha-sig.figma.com/img/3681/5689/c0a30ad311c799c5c10a602d5d708580?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OxBleCST8wO8ssgIfWWh3bHY70EW0ELSb3dH4iwA5o1mcvK3bs~SEX4SKPs~r8GrCiMNHJzv7Qs6y1i04-IqnAnPB~mrcrrBotIyHzV~Ef3FYzsEBBLvtpRF-dJ0dbeVrEQ05keO1FQ4uVZqiNjyDSlsZ1xX3rAjp~GRRFN6wKu7mZqhOWM5SoZi9uJtloCkB-l-AFVzHMuWnhR6qnqXTpqdgKNNp8pE9o50-llF-mYQ9XKus8TCuAP9ShB6ya0PojQVO8YjCWkZWr7mElHGz0Jc4npzd1mWF~R3LKpio1ID0HeNIQ8AzpFqTAgHUDWX0HBu8jdQynM1pPVGnxc9WQ__',
  //     name: 'Meo Meo',
  //     dob: '22-11-2022',
  //     petType: 'Giống: abchd',
  //     vaccine: true
  //   ),
  //   Pet(
  //     imageUrl: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
  //     name: 'Kanlyly',
  //     dob: 'Chó con - 3kg',
  //     petType: 'Giống: abchd',
  //     vaccine: true,
  //   ),
  //   // Add more pets as needed
  // ];
  List<Pet> pets =[];
  List<Pet> choose = [];
  void _onPetSelected(bool selected) {
    setState(() {
      isPetSelected = selected;
    });
  }
  void loadPet() async{
    List<Pet> pet = await ServiceAPI.getPetnow();
    setState(() {
      pets = pet;
    });
  }
String PetType(int type){
  if (type == 1) return "Dog";
  else if(type == 2)
  return "Cat";
  else if(type == 3)
  return "Rabbit";
  return "Hamster";
}

@override
  void initState() {
    loadPet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn thú cưng',
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
          onPressed: () {
            /*
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyServiceScreen()),
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
                itemCount: pets!.length,
                itemBuilder: (context, index) {
                  final pet = pets![index];
                  return PetCard(
                    imageUrl: pet.image == null?"https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__":pet.image!,
                    name: pet.name!,
                    dob: pet.dob == null?"":pet.dob!,
                    petType: PetType(pet.petType!),
                    onSelected: _onPetSelected,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectServiceScreen(pets: pets, check: 0,listpet: [],sum: 0,)),
                );
                
                //Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPetSelected ? Color(0xFFF49FA4) : Colors.grey.shade400,
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
          )
        ],
      ),
    );
  }
}


class PetCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String dob;
  final String petType;
  final Function(bool) onSelected;

  const PetCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.dob,
    required this.petType,
    required this.onSelected,
  }) : super(key: key);

  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      widget.onSelected(isSelected);
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
                  child: getImageWidget(widget.imageUrl, 100, double.infinity),
                  /*
                  Image.network(
                    widget.imageUrl,
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),*/
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.dob,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.petType,
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
                side: BorderSide(color: const Color.fromARGB(255, 189, 189, 189)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}