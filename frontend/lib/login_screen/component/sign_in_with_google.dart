import 'package:flutter/material.dart';
import 'package:frontend/class_model/uSer.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/login_screen/api/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInWithGoogleScreen extends StatefulWidget {
  const SignInWithGoogleScreen({super.key});

  State<SignInWithGoogleScreen> createState() => _SignInWithGoogleScreenState();
}

class _SignInWithGoogleScreenState extends State<SignInWithGoogleScreen> {
  final TextEditingController _usernameController = TextEditingController();

  // Future<void> _handleInputUsername() async {
  //   String? username = _usernameController.text;
  //   try {
  //     GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
  //     GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //     final accessToken = googleAuth.accessToken;
  //     await GoogleSignInApi.SigninwithGoogle(username, accessToken!);
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => mainHomePage()));
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> _handleInputUsername() async{
    String? username = _usernameController.text;
    try{
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      await GoogleSignInApi.SigninwithGoogle(username,accessToken!);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => customerHomePage(selected: 0,)  ));
    }
    catch(e){
      print(e);
    }
  }
  /*
  late Profile myprofile;
  bool LoadProfile = false;
  void getMyProfile() async{
    setState(() async {
      myprofile = await ProfileAPI.getMyProfile();
      LoadProfile = false;
      print(LoadProfile);
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleInputUsername,
              child: Icon(Icons.arrow_forward),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
