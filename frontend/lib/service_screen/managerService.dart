import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/service_screen/reService/addService.dart';
import 'package:frontend/service_screen/reService/serviceDetail.dart';
import 'package:frontend/service_screen/reService/serviceGet.dart';
import 'package:frontend/view_model/serviceItemView.dart';

class reServicePage extends StatefulWidget {
  const reServicePage({super.key});

  @override
  State<reServicePage> createState() => _reServicePageState();
}

class _reServicePageState extends State<reServicePage> {
  late List<ServiceItem> services ;
  
  bool isLoaded = false;
  
  void getAllService() async{
    services = await GetService.GetAllService();
    setState(() {
      isLoaded = true;
      print(isLoaded);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllService();
    super.initState();
  }
  /*
  final List< ServiceItem > services = [
    ServiceItem(
      imageLink: 'https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HedJBnbEpvN2kis0akNSBYAhlPv5ijVMwLFL3FoFNHnUiMpN4IEKOhfqkLJZAwG3KONImVnA44Q76AZzInFuU9PUrJokA3F55rcrU0mZX6Ib6in0IzDGbv42bNJMNkADyPLo~9akE4DZIxMGOm0iUAKwOlAFxDPNdETjFBXYxt-7AX1-RYFlnz230vGkHN2aBW3h0lunmR4-QKqOe1PIAqp55VK0lmbiCUdn-N9cQAoeRvXzMvLLN9vEzJzfHJGMn8aJHe9ZE796zglNPwADRVazIZM~3UmJYHUNA-~mkGKhLe1av5uhIo7x8zFVr5o7tXF98FzeARZvx~E7B6oY1A__',
      title: 'Combo: dịch vụ tắm, vệ sinh và tỉa lông',
      price: 'đ 12.500',
      description: 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaađá'
    ),
    ServiceItem(
      image: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
      name: 'Pate cho mèo Whiskas 80g hương Cá Biển',
      price: '12.500',
      description: ''
    ),
  ];
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tất cả dịch vụ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Popins",
          ),
        ),
        backgroundColor: Color(0xFFF49FA4),
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
        /*
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {/*
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewOrderScreen()),
            );*/
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddServicePage()),
            );
          },
        ),
        */
      ),
      body:isLoaded == false?
      const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trong lưới
            childAspectRatio: 0.85, // Tỷ lệ chiều cao/chiều rộng cho các item
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 25.0,
          ), 
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Center(
              child:
              /*
              buildBestSellerItem(
                products[index]['imageLink']!,
                products[index]['title']!,
                products[index]['price']!,
                () {
                // Hàm được gọi khi nhấn vào item
                print('Nhấn vào sản phẩm: ${products[index]['title']}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product, cartItemCount: cartItemCount,),
                  ),
                );
                // Hoặc chuyển trang đến trang chi tiết sản phẩm
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: products[index])));
                },
              ),*/
              buildServiceItem(services[index], 
                            () {
                  // Điều hướng đến trang chi tiết khi nhấn vào item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailPage(
                        serviceItem: services[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddServicePage(), 
                    ),
          );
          /*
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewOrderScreen()),
          );*/
        }, 
        
        label: const Text('Đơn mới', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF49FA4),
        icon: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}