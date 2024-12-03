import 'package:flutter/material.dart';
import 'package:frontend/class_model/service_item.dart';
import 'package:frontend/view_model/itemView_sqr.dart';

class Allservice extends StatefulWidget {
  const Allservice({super.key});

  @override
  State<Allservice> createState() => _AllserviceState();
}

class _AllserviceState extends State<Allservice> {

  final List< ServiceItem > services = [
    ServiceItem(
      imageLink: 'https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HedJBnbEpvN2kis0akNSBYAhlPv5ijVMwLFL3FoFNHnUiMpN4IEKOhfqkLJZAwG3KONImVnA44Q76AZzInFuU9PUrJokA3F55rcrU0mZX6Ib6in0IzDGbv42bNJMNkADyPLo~9akE4DZIxMGOm0iUAKwOlAFxDPNdETjFBXYxt-7AX1-RYFlnz230vGkHN2aBW3h0lunmR4-QKqOe1PIAqp55VK0lmbiCUdn-N9cQAoeRvXzMvLLN9vEzJzfHJGMn8aJHe9ZE796zglNPwADRVazIZM~3UmJYHUNA-~mkGKhLe1av5uhIo7x8zFVr5o7tXF98FzeARZvx~E7B6oY1A__',
      title: 'Combo: dịch vụ tắm, vệ sinh và tỉa lông',
      price: 'đ 12.500',
    ),
    ServiceItem(
      imageLink: 'https://s3-alpha-sig.figma.com/img/5962/56b3/457374b16b2eafb3702028ca2627d093?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QoMDZUHMN-3SuTHypcgDZvr0Tf-n7mUptmwdWyQvIp1OahXgTSG4sHBoP1ZyzAKixVcbkf0w8Dp8zuR17TWOrRecGkC6jALXXYAcGD1Oqc3w7-a3hzG75KQBP~QuERGdczJMHE00ljyvt0qETAX7mG7lTTkiezK7vsTt61ywesisaNufD-5vPKCuWGbeq2tjdezUib4~3zDjDXYgJMYvmXo5sijGZw42rWTZueunaqAJ6gkgVr~sihYfN-CdvqczZKlsU8nH1QXBIPWu2uXjpPnkwcHurkBwJWhjkRi~zbjGqyT-Zg3YBo78HcEoxbWqdLhO3-Dpwrmsbqas1nvjVQ__',
      title: 'Pate cho mèo Whiskas 80g hương Cá Biển',
      price: 'đ 12.500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trong lưới
            childAspectRatio: 1, // Tỷ lệ chiều cao/chiều rộng cho các item
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 25.0,
          ), 
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Center(
              child: buildBestSellerItem(
                services[index].imageLink!,
                services[index].title!,
                services[index].price!,
                () {
                // Hàm được gọi khi nhấn vào item
                print('Nhấn vào sản phẩm: ');
                
                // Hoặc chuyển trang đến trang chi tiết sản phẩm
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: products[index])));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}