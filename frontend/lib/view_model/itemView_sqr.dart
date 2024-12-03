import 'package:flutter/material.dart';

Widget buildBestSellerItem(String imageLink, String title, String price, VoidCallback onTap) {

  return GestureDetector(
    onTap: onTap, // Hàm được gọi khi nhấn vào item
    child: Container(
      width: 146,
      //height: 200,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFF49FA4),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: getImageWidget(imageLink),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '₫ $price',
              style: TextStyle(color: Colors.red),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getImageWidget(String imagePath) {
  
  bool isUrl = Uri.tryParse(imagePath)?.hasAbsolutePath ?? false;

  if (isUrl) {
    // Nếu là URL, dùng Image.network
    return Image.network(imagePath,
      height: 130,
      width: 146,
      fit: BoxFit.cover,
    );
  } else {
    // Nếu là đường dẫn Asset, dùng Image.asset
    return Image.asset(
      imagePath,
      height: 130,
      width: 146,
      fit: BoxFit.cover,
    );
  }
}