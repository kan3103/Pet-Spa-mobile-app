import 'package:flutter/material.dart';
import 'package:frontend/class_model/product_model.dart';
import 'package:frontend/productPage/cart_page.dart';
import 'package:frontend/productPage/product_detail.dart';
import 'package:frontend/view_model/itemView_sqr.dart'; 

class productScreen extends StatefulWidget {
  const productScreen({super.key});

  @override
  State<productScreen> createState() => _productScreenState();
}

class _productScreenState extends State<productScreen> {

  int cartItemCount = 200 ; 

  Product product = 
    Product(
      name: "Thức ăn mèo Catchy", 
      description: "None", 
      images: ["https://s3-alpha-sig.figma.com/img/63c1/1517/7e58f2a33adb3644239ee9fe79d69ccc?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BtTtZiHdra-lHoefBZaAnJngN6QTeHHMWiD1JRWb~-v-mhsZK3OeUkQPetTY1JJ~LZoJlvPTqJNuSR3nXYCdluYSeKp6uXpj0GmG4gayd4qcqJ8P8m33qpZMU9vFR4A0vJ55BRh6Ck7PXipUs4o~KbmIAYAkiR1CKlyzRmx4jiPRTWYXy16HIuv99doFCpqPwXhNythFXGbViKtzYd5cE2RH74Yvl~f8~x~cn4ZDTbPR4U4~NTDe8KL8ERCIos5xXe7eUmebKRyICDYTszgaUJDkaARvSRAO9s1pqeg2NXxlDDZihDiIWlR1vE76BWCUBSQ~oHxsKxcwnSnpZtzOow__","https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=D-10PEs5d4neCSimTbZndw-cP-aFf7uLu6kw5sbz~4nf0rF11MH730tjRxrAHGlQ6ab8GCh4lRjtozxNvibrT8eWv3r31dqYcRpTrZ~j-QF5Nu40JVnq6PVXhCqYqn1h~tSSuTTZLFBNxMIgfXerWdFAM0oHjPZWJ~E1Cgd17EF8jVeSuLKTG1Xpbj5cYrDTfNNmtXef4-k2XO-~QH9~nKjt4rQQpbdg5iMVRTB9ka4lVNLuyx6ky0NA~cCejqcTA375QaP6yORleFjE41A0LOAJ0eB9p3-XkwJTEJZH8FCXFvnsRSqyiSeJKMzbox1cQr8dRWAE~rirkrjB2MlGqA__"], 
      price: 27000, 
      categories: ["Mèo con - 400g", "Mèo lớn - 400g", "Mèo lớn - 1kg"]) ;

  final List<Map<String, String>> products = [
    {
      'imageLink': 'assets/images/image 32.png',
      'title': 'Pate cho mèo Whiskas 80g hương Cá Biển',
      'price': '12,500',
    },
    {
      'imageLink': 'assets/images/image 32.png',
      'title': 'Pate cho mèo Whiskas 80g hương Cá Biển',
      'price': '12,500',
    },
    {
      'imageLink': 'assets/images/image 32.png',
      'title':'Pate cho mèo Whiskas 80g hương Cá Biển',
      'price': '12,500',
    },
    // Thêm các sản phẩm khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product' , style:  TextStyle(fontWeight: FontWeight.bold , color: Colors.white ),),
        backgroundColor: Color( 0xFFF49FA4),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart , color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(), // Gọi trang CartPage
                    ),
                  );
                },
              ),
              if (cartItemCount > 0) // Hiển thị thông báo nếu có sản phẩm trong giỏ
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trong lưới
            childAspectRatio: 1, // Tỷ lệ chiều cao/chiều rộng cho các item
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 25.0,
          ), 
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Center(
              child: buildBestSellerItem(
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
              ),
            );
          },
        ),
      ),
    );
  }
}