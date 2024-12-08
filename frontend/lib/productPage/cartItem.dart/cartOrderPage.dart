import 'package:flutter/material.dart';
import 'package:frontend/productPage/cartItem.dart/cartOrder.dart';
import 'package:frontend/productPage/cartItem.dart/cartServicemodel.dart';

class Cartorderpage extends StatefulWidget {
  @override
  _CartorderpageState createState() => _CartorderpageState();
}

class _CartorderpageState extends State<Cartorderpage> {
  // Danh sách sản phẩm trong giỏ hàng
  late List<Cartservicemodel> cartItems = [
     Cartservicemodel(
        id: 1,
        pet: 'Khangly', 
        image: '',
        service: 'Lam gi do',
        price: 150000 
      
    ),
    Cartservicemodel(
        id: 1,
        pet: 'Khangly', 
        image: '',
        service: 'Lam gi do',
        price: 180000 
    ),
  ] ;

  // Tính tổng tiền
  double calculateTotal() {
    return cartItems.fold(
        0, (sum, cartItem) => sum + (cartItem.price! ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
        title: Text(
          "My cart",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Chỉnh sửa",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return cartOrderItem(
                  cartItem: cartItem,
                );
              },
            ),
          ),
          TotalPrice(
            totalAmount: calculateTotal(),
            itemCount: cartItems.length,
          ),
        ],
      ),
    );
  }
}