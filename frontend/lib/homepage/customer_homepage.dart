import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/api/getProfile.dart';
import 'package:frontend/homepage/home_screen.dart';
import 'package:frontend/login_screen/api/google_sign_in.dart';
import 'package:frontend/productPage/cartItem.dart/cartOrderPage.dart';
import 'package:frontend/productPage/productScreen.dart';
import 'package:frontend/login_screen/login_screen.dart';
import 'package:frontend/service_screen/managerService.dart';
import 'package:frontend/service_screen/service_screen.dart';
import 'package:frontend/startedpage/started_page.dart';
import 'package:frontend/informationPage/inforScreen.dart';

final GlobalKey<_customerHomePageState> mainHomePageKey = GlobalKey();

class customerHomePage extends StatefulWidget {
  /*
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
  */
  final int selected;
  
  customerHomePage({Key? key, required this.selected}) : super(key: key);
  @override
  _customerHomePageState createState() => _customerHomePageState();
}

class _customerHomePageState extends State<customerHomePage> {
  bool LoadProfile = true;
  int selectedIndex = 0 ;
  Profile? myprofile;
  void getMyProfile() async{
    myprofile = await ProfileAPI.getMyProfile();
    print(myprofile);
    setState(() {
      LoadProfile = false;
      selectedIndex = widget.selected;
      print(LoadProfile);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMyProfile();
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() { // Update state when a tab is tapped
      selectedIndex = index;
    });
  }
    DateTime? lastPressed;
    Future<bool> _onWillPop() async { 
      final DateTime now = DateTime.now();
      if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 2)) { //Set the interval to 2 clicks
        lastPressed = now;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nhấn thêm lần nữa để thoát')),
        );
        return Future.value(false);
      }
      return Future.value(true);
    }
  
  Widget build(BuildContext context) {

    Widget page;

    switch (selectedIndex) {
      case 0:
        page =  HomeScreen(profile: myprofile);
        break;
      case 1:
        page = MyServiceScreen();
        
        break;
      case 2:
        page = Cartorderpage()  ; // Thay bằng màn hình Thanh toán
        break;
      case 3:
        page = productScreen();
        break;
      case 4:
        page =  Inforscreen(profile:  myprofile,); // Thay bằng màn hình Cài đặt
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _onWillPop() ?? false;
        if (context.mounted && shouldPop) {
          GoogleSignInApi.logout();
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: LoadProfile?const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )):page,
      
        bottomNavigationBar: Container(
            color: Colors.lightGreen,
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              backgroundColor: Color(0xFFF49FA4),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home) ,
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Shopping',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: onItemTapped,
            ),
          ),
      
      ),
    );
  }
}