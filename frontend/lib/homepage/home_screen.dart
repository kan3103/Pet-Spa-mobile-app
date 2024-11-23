import 'package:flutter/material.dart';
import 'package:frontend/homepage/homepage.dart';
import 'package:frontend/view_model/itemView_sqr.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchActive = false;

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
    });
  }

  void _switch_screen(int this_index){
    mainHomePageKey.currentState?.onItemTapped(this_index);
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*
                  !_isSearchActive? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Khang Lý',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Good Morning!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ) 
                  : SizedBox(width: 0 ,),*/
                  
                  AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height:  _isSearchActive ?60 : 60,
                        width: _isSearchActive ?280 : 200,
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: _isSearchActive? TextFormField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: "Tìm kiếm...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: (){}, 
                                    icon: Icon(Icons.search) , 
                                  ),
                                ),
                                
                              )
                              :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi Khang Lý',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Good Morning!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:(){
                          _toggleSearch();
                        },
                         icon: Icon(Icons.search, size: 28),
                      ),
                     // !_isSearchActive ? 
                      IconButton(
                        onPressed:(){},
                         icon: Icon(Icons.notifications, size: 28),
                      ) 
                      //: SizedBox(width: 0,)
                      ,
                    ],
                  ),
                ],
              ),
              /*
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _isSearchActive ? 60.0 : 0.0,
                //width: 60,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: _isSearchActive? TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.search) , 
                          ),
                        ),
                        
                      )
                : null,
          ),*/
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF49FA4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/pet_img.png',
                       width:   MediaQuery.of(context).size.width*0.8,
                    ),
                    
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Category section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryItem(Icons.person, 'Service',0),
                  _buildCategoryItem(Icons.shopping_bag, 'Product',2),
                  _buildCategoryItem(Icons.pets, 'Pet',0),
                ],
              ),
              SizedBox(height: 20),

              // Best seller of Service
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best seller of Service',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildBestSellerItem(
                        'assets/images/image 29.png','Combo: Dịch vụ tắm, vệ sinh và tỉa lông', '500.000',
                        (){
                          print('Nhấn vào Combo: Dịch vụ tắm, vệ sinh và tỉa lông');
                        }
                        ),
                    buildBestSellerItem(
                        'assets/images/image 30.png','Dịch vụ: Tiêm vacxin, xổ lãi, triệt sản', '300.000 - 1.000.000',(){}),
                    buildBestSellerItem(
                        'assets/images/image 31.png','Dịch vụ: Điều trị bệnh ngoài da, ghẻ, nấm', '300.000 - 1.000.000',(){}),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Best seller of Product
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best seller of Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildBestSellerItem(
                        'assets/images/image 32.png','Pate cho mèo Whiskas 80g hương Cá Biển', '12.500',(){}),
                    buildBestSellerItem(
                        'assets/images/image 33.png','Cát vệ sinh cho mèo Mooncat', '55.000',(){}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create Category Item
  Widget _buildCategoryItem(IconData icon, String label, int this_index) {
    return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      FloatingActionButton(
        onPressed:(){
          if(this_index == 2 ) _switch_screen(this_index);
        },
        backgroundColor: Color(0xFFF49FA4),
        elevation: 2.0,
        child: Icon(icon, color: Colors.white, size: 30),
        shape: CircleBorder(),
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
    ],
  );
  }
}
