import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/homepage/manager_homepage.dart';
import 'package:frontend/informationPage/manager/api/managerApi.dart';
import 'package:frontend/informationPage/manager/managerprofile.dart';

class Addstaff extends StatefulWidget {
  const Addstaff({super.key});

  @override
  State<Addstaff> createState() => _AddstaffState();
}

class _AddstaffState extends State<Addstaff> {

  // Controllers for text fields
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to print out values of the text fields
  void _printAccountInfo() {
    ManagerAPI.addStaff(_usernameController.text,_passwordController.text, _emailController.text, _lastnameController.text, _firstnameController.text);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => managerHomePage(selected: 4)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo Tài Khoản'),
        backgroundColor: Color(0xFFF49FA4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            // Firstname TextField
            TextField(
              controller: _firstnameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Lastname TextField
            TextField(
              controller: _lastnameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            // Username TextField
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Password TextField
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Hide password input
            ),
            SizedBox(height: 30),

            // Button to create account
            Center(
              child: ElevatedButton(
                onPressed: _printAccountInfo,
                child: Text('Tạo Tài Khoản'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF49FA4),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}