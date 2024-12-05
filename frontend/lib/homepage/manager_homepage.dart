import 'package:flutter/material.dart';
import 'package:frontend/homepage/home_screen.dart';
import 'package:frontend/productPage/productScreen.dart';
import 'package:frontend/login_screen/login_screen.dart';
import 'package:frontend/service_screen/service_screen.dart';
import 'package:frontend/startedpage/started_page.dart';

final GlobalKey<_managerHomePageState> mainHomePageKey = GlobalKey();

class managerHomePage extends StatefulWidget {
  /*
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
  */
  managerHomePage({Key? key}) : super(key: mainHomePageKey);
  @override
  _managerHomePageState createState() => _managerHomePageState();
}

class _managerHomePageState extends State<managerHomePage> {
  @override

  int selectedIndex = 0 ;

  void onItemTapped(int index) {
    setState(() { // Update state when a tab is tapped
      selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {

    Widget page = HomeScreen();

    switch (selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page =  MyServiceScreen();
        break;
      case 2:
        page = productScreen(); // Thay bằng màn hình Thông báo
        break;
      case 3:
        page = productScreen() ; // chỉnh
        break;
      case 4:
        page =  GetStartedPage(); // Thay bằng màn hình Quản lí
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: page,

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
              icon: Icon(Icons.shopping_bag),
              label: 'Shopping',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),

    );
  }
}