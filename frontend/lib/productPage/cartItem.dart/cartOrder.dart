import 'package:flutter/material.dart';
import 'package:frontend/productPage/cartItem.dart/cartServicemodel.dart';

class cartOrderItem extends StatelessWidget {
  final Cartservicemodel cartItem;
  
  cartOrderItem({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFF49FA4).withOpacity(0.2),
          border: Border.all(
                  color: Color(0xFFF49FA4).withOpacity(0.2), // Màu viền
                  width: 2, // Độ dày của viền
          ),
        ) ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: Colors.grey[200],
                  color:  Color(0xFFF49FA4),
                  border: Border.all(
                    color: Color(0xFFF49FA4), // Màu viền
                    width: 2, // Độ dày của viền
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6), // Đảm bảo nội dung không che viền
                  child: cartItem.image! != null && cartItem.image! != ''
                      ? Image.network(
                          cartItem.image!,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.service!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      cartItem.pet!,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${cartItem.price} đ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  final double totalAmount;
  final int itemCount;

  TotalPrice({required this.totalAmount, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng cộng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${totalAmount} đ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF49FA4),
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Đặt hàng ($itemCount)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}