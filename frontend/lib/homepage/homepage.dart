import 'package:flutter/material.dart';
import 'package:frontend/homepage/home_screen.dart';
import 'package:frontend/productPage/productScreen.dart';
import 'package:frontend/login_screen/login_screen.dart';
import 'package:frontend/startedpage/started_page.dart';

final GlobalKey<_mainHomePageState> mainHomePageKey = GlobalKey();

class mainHomePage extends StatefulWidget {
  /*
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
  */
  mainHomePage({Key? key}) : super(key: mainHomePageKey);
  @override
  _mainHomePageState createState() => _mainHomePageState();
}

class _mainHomePageState extends State<mainHomePage> {
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
        page =  LoginScreen();
        break;
      case 2:
        page = productScreen();
        break;
      case 3:
        page =  HomeScreen();
        break;
      case 4:
        page =  GetStartedPage();
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