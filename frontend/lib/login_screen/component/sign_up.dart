import 'package:flutter/material.dart';
import 'package:frontend/login_screen/api/sign_up.dart';
import 'package:frontend/login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSignUpSelected = true;
  bool agreeToTerms = false;
  bool checkBlank = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reNewPasswordController = TextEditingController();


  
  Future SiginUp() async {
    try{
      await SignUpApi.signupcus(_emailController.text, _newPasswordController.text, _reNewPasswordController.text);
      _showNotification('Sign up successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    }
    catch (error) {
      _showNotification(error.toString());
    }
  }

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

  void _checkFields() {
    setState(() {
      checkBlank = _emailController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _reNewPasswordController.text.isEmpty ||
          !agreeToTerms;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _newPasswordController.addListener(_checkFields);
    _reNewPasswordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _reNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Water is life. Water is a basic human need. In various lines of life, humans need water.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _newPasswordController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _reNewPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value!;
                    _checkFields();
                  });
                },
              ),
              Expanded(
                child: Text(
                  'I agree to the Terms of Service and Privacy Policy',
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: checkBlank ? null : () {
            SiginUp();
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: checkBlank ? Colors.white : Colors.black,
            backgroundColor: checkBlank ? Colors.grey[300] : Colors.pink,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}