import 'package:flutter/material.dart';
import 'package:frontend/login_screen/component/header_section.dart';
import 'package:frontend/login_screen/component/sign_in.dart';
import 'package:frontend/login_screen/component/sign_up.dart';
import 'package:frontend/login_screen/component/tab_selection.dart';
import 'package:frontend/login_screen/forgot_password.dart';
import 'package:frontend/login_screen/create_username.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isSignUpSelected = false;
  bool keepMeSignedIn = false;

  void _showNotification(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void updateIsSignUpSelected(bool value) {
    setState(() {
      isSignUpSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF49FA4), // Entire screen background color
      body: Stack(
        children: [
          Column(
            children: [
              headerSection(context), // Top part
              Expanded(
                // Bottom 7/10 section
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TabSelection(
                                isSignUpSelected: isSignUpSelected,
                                onSelectionChanged: (value) =>
                                    {updateIsSignUpSelected(value)}),
                            !isSignUpSelected ? SignInScreen() : SignUpScreen(),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
          !isSignUpSelected
              ? AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: MediaQuery.of(context).size.height * 0.3 - 55,
                  left: MediaQuery.of(context).size.width / 2 - 215,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.47, // Show only the top half of the image
                      child: Image.asset(
                        'assets/images/catforsignin.png',
                        width: 250, // Adjust the width as needed
                        height: 250, // Adjust the height as needed
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: MediaQuery.of(context).size.height * 0.3 - 55,
                  left: MediaQuery.of(context).size.width / 2 - 45,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.47, // Show only the top half of the image
                      child: Image.asset(
                        'assets/images/catforsignin.png',
                        width: 250, // Adjust the width as needed
                        height: 250, // Adjust the height as needed
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
