import 'package:flutter/material.dart';
import 'package:frontend/homepage/manager_homepage.dart';
import 'package:frontend/homepage/staff_homepage.dart';
import 'package:frontend/login_screen/forgot_password.dart';
import 'package:frontend/login_screen/component/sign_in_with_google.dart';
import 'package:frontend/login_screen/api/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homepage/customer_homepage.dart';
import '../api/token_storage.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isSignUpSelected = false;
  bool keepMeSignedIn = false;
  bool checkBlank = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  // Future<void> _handleGoogleSignIn() async {
  //
  //   try {
  //     GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
  //     GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //     final accessToken = googleAuth.accessToken;
  //     await GoogleSignInApi.loginWithGoogle(accessToken!)?
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()  )):
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Getusername()  ));
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future signInWithGoogle() async {
    try{
      await GoogleSignInApi.logout();
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      await GoogleSignInApi.loginWithGoogle(accessToken!)?
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => customerHomePage(selected: 0,)  )):
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInWithGoogleScreen()  ));
    }
    catch (error) {
      print(error);
    }
  }

  void _checkFields() {
    setState(() {
      checkBlank =
          _emailController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  Future signIn() async {
    try {
      await TokenStorage.fetchToken(
          _emailController.text, _passwordController.text);
      final prefs = await SharedPreferences.getInstance();
      String accountType = prefs.getString('account')!;
      print(accountType);
      if (accountType == 'customer') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  customerHomePage(selected: 0,)));
      }
      else if (accountType == 'staff') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  staffHomePage(selected: 0,)));
      }
      else if (accountType == 'manager') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  managerHomePage(selected: 0,)));
      }
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));}
    } catch (e) {
      _showNotification('Thông tin không hợp lệ');
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: keepMeSignedIn,
                    onChanged: (value) {
                      setState(() {
                        keepMeSignedIn = value!;
                      });
                    },
                  ),
                  Text('Keep me signed in'),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: Text('Forgot password?'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: checkBlank
              ? null
              : () {
                  // _showNotification('Sign In Successful');
                  signIn();
                },
          child: Text(
            'Sign in',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: checkBlank ? Colors.white : Colors.white,
            backgroundColor: checkBlank ? Colors.grey[300] : Color(0xFFC56262),
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: signInWithGoogle,
          // {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => SignInWithGoogleScreen()),
          //   );
          // },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google.png',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
