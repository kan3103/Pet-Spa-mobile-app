import 'package:flutter/material.dart';
import 'package:frontend/class_model/cart_Item.dart';
import 'package:frontend/class_model/product_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Danh sách sản phẩm trong giỏ hàng
  List<CartItem> cartItems = [
    CartItem(
      product: Product(
        name: "Thức ăn mèo Catchy",
        description: "Mèo con - 400g",
        images: ["https://s3-alpha-sig.figma.com/img/63c1/1517/7e58f2a33adb3644239ee9fe79d69ccc?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ay5e8x~pjUMlG6Gdb5GHLI0eG4h~XKPu7anSKhX~Ego1pU622Cpf4VpNM6qRavID9h0aBT~h-ShE4Dy9miA9bzh90RTDtI6iT8R8z956kwuTY0wSceEztszwz9RpD4wVI-44nxOF-jYFojvz36SHG8aoiA0J2AjjXJu0B8E6~GHQ7InJ9tWYKEEhsyP3SURb8~WSUE7FfRb7-ih~dG7fTNkzlThLpEJ6bm5zL3dp7n0vP1OOhyOhEFDuSWi1Yxs~oaxEpblv-weL7FJQeOQiISetNyImAgzhIhNQv27Cq-XAd7v00p2qFv7A4qk2OYqAWJYe5WAIKL3tgGugW89Q2A__"],
        price: 27500,
        categories: ["Thức ăn", "Mèo"],
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        name: "Thức ăn chó Whiskas",
        description: "Hương vị bò 80g",
        images: ["https://s3-alpha-sig.figma.com/img/4009/7ae7/9cb0107b84d4cd568e8f572ba06a0e62?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=McoSeYpXQ181hZdIR8UlmG~Cy4c1Joj10myIPoGAz4nVPnSdidVoqOr~JOqjCVJm525d5tfwpkc4ZcDaoVCedo6KqEeSOgyzHYZXTKHwso5YX-isWuWvZXHiD~M8PRfsYgVgtgHvqBIsyp9sU0ZCs7WoqH2B2VSr1YcDwmhekHbqr31nBaOaXYJi1HXc8VfCrhVdO-8z~vcyGr-vfHbOX~Xj9kuBLsHwAaN0FCBRowRu1Om7tbp21wyxIL9mLR2n1-UHU6hPm5g1zfGNZQ0-siwhxjphDG8mREC0Wz6hNpFHz4ELJEwOrBMzkkP7l~01l7B7PGoaTJZ~2xSAuZ~6MQ__"],
        price: 2500,
        categories: ["Thức ăn", "Chó"],
      ),
      quantity: 2,
    ),
  ];

  // Tính tổng tiền
  double calculateTotal() {
    return cartItems.fold(
        0, (sum, cartItem) => sum + (cartItem.product.price * cartItem.quantity));
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
            Navigator.pop(context);
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
                return CartItemWidget(
                  cartItem: cartItem,
                  onRemove: () {
                    setState(() {
                      if (cartItem.quantity > 1) {
                        cartItem.quantity--;
                      }
                    });
                  },
                  onAdd: () {
                    setState(() {
                      cartItem.quantity++;
                    });
                  },
                );
              },
            ),
          ),
          TotalSection(
            totalAmount: calculateTotal(),
            itemCount: cartItems.length,
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  CartItemWidget({
    required this.cartItem,
    required this.onRemove,
    required this.onAdd,
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
                  child: cartItem.product.images.isNotEmpty
                      ? Image.network(
                          cartItem.product.images[0],
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
                      cartItem.product.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      cartItem.product.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${cartItem.product.price * cartItem.quantity} đ",
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
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: onRemove,
                  ),
                  Text(
                    cartItem.quantity.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.blue),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalSection extends StatelessWidget {
  final double totalAmount;
  final int itemCount;

  TotalSection({required this.totalAmount, required this.itemCount});

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
