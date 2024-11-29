import 'package:flutter/material.dart';
import 'package:frontend/login_screen/component/sign_in.dart';
import 'package:frontend/login_screen/component/sign_up.dart';

class TabSelection extends StatefulWidget {
  final bool isSignUpSelected;
  final ValueChanged<bool> onSelectionChanged;

  TabSelection(
      {required this.isSignUpSelected, required this.onSelectionChanged});

  @override
  _TabSelectionState createState() => _TabSelectionState();
}

class _TabSelectionState extends State<TabSelection> {
  bool isSignUpSelected = false;

  @override
  void initState() {
    super.initState();
    isSignUpSelected = widget.isSignUpSelected;
  }

  void _toggleTab() {
    setState(() {
      isSignUpSelected = !isSignUpSelected;
    });
    widget.onSelectionChanged(isSignUpSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // Added vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (isSignUpSelected) {
                    _toggleTab();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInScreen()),
                    // );
                  }
                },
                child: Column(
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    if (!isSignUpSelected)
                      Container(
                        width: 60,
                        height: 2,
                        color: Colors.pinkAccent,
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!isSignUpSelected) {
                    _toggleTab();
                  }
                },
                child: Column(
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (isSignUpSelected)
                      Container(
                        width: 60,
                        height: 2,
                        color: Colors.pinkAccent,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
