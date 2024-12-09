import 'package:flutter/material.dart';
import 'package:frontend/class_model/product_model.dart';
import 'package:frontend/productPage/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final int cartItemCount;
  const ProductDetailPage({
    Key? key, 
    required this.product ,  
    required this.cartItemCount 
    }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  String? selectedCategory = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart , color: Colors.white,),
                 onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>CartPage(), // Gọi trang CartPage
                    ),
                  );
                },
              ),
              if (widget.cartItemCount > 0) 
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
                      '${widget.cartItemCount}',
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
        backgroundColor: Color( 0xFFF49FA4),
        //title: Text("Catchy"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh sản phẩm
            Container(
              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.product.images[0], fit: BoxFit.cover),
            ),
            SizedBox(height: 16),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'đ ${widget.product.price.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            SizedBox(height: 8),

          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),

            // Phân loại sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Phân loại",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: widget.product.categories.map((category) {
                  return ListTile(
                    title: Text(category),
                    leading: Radio<String>(
                      value: category,
                      groupValue: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),

            // Số lượng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 20 ,
                height: 70,
                child: ElevatedButton(
                  
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color( 0xFFF49FA4),
                  ),
                  child: Center(
                    child: Text(
                      selectedCategory == null ? "Chọn các thông tin cần thiết!" :"Thêm vào giỏ hàng - đ ${(widget.product.price * quantity).toStringAsFixed(0)}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}