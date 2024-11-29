import 'package:flutter/material.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:frontend/service_screen/serviceCart.dart';

class Service {
  final String imageUrl;
  final String name;
  final String price;

  Service({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}


class SelectServiceScreen extends StatefulWidget {
  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool isServiceSelected = false;

  final List<Service> services = [
    Service(
      imageUrl: 'https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HedJBnbEpvN2kis0akNSBYAhlPv5ijVMwLFL3FoFNHnUiMpN4IEKOhfqkLJZAwG3KONImVnA44Q76AZzInFuU9PUrJokA3F55rcrU0mZX6Ib6in0IzDGbv42bNJMNkADyPLo~9akE4DZIxMGOm0iUAKwOlAFxDPNdETjFBXYxt-7AX1-RYFlnz230vGkHN2aBW3h0lunmR4-QKqOe1PIAqp55VK0lmbiCUdn-N9cQAoeRvXzMvLLN9vEzJzfHJGMn8aJHe9ZE796zglNPwADRVazIZM~3UmJYHUNA-~mkGKhLe1av5uhIo7x8zFVr5o7tXF98FzeARZvx~E7B6oY1A__',
      name: 'Combo: dịch vụ tắm, vệ sinh và tỉa lông',
      price: 'đ 12.500',
    ),
    Service(
      imageUrl: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
      name: 'Pate cho mèo Whiskas 80g hương Cá Biển',
      price: 'đ 12.500',
    ),
  ];

  void _onPetSelected(bool selected) {
    setState(() {
      isServiceSelected = selected;
    });
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewOrderScreen()),
            );
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
                  return ServiceCard(
                    imageUrl: service.imageUrl,
                    name: service.name,
                    price: service.price,
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
                  MaterialPageRoute(builder: (context) => ServiceCartScreen()),
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
            ),
          ),
        ],
      ),
    );
  }
}


class ServiceCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final Function(bool) onSelected;

  const ServiceCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onSelected,
  }) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
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
                  child: Image.network(
                    widget.imageUrl,
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
                        widget.name,
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