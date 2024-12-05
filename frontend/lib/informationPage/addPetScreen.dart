// import 'package:flutter/material.dart';
// import 'package:frontend/informationPage/inforScreen.dart';
//
//
// class AddPetScreen extends StatefulWidget {
//   @override
//   _AddPetScreenState createState() => _AddPetScreenState();
// }
//
// class _AddPetScreenState extends State<AddPetScreen> {
//   bool isAddPetSelected = true;
//   bool checkBlank = true;
//
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _accessTokenController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _isVaccineController = TextEditingController();
//   final TextEditingController _avatarController = TextEditingController();
//   final TextEditingController _petTypeController = TextEditingController();
//
//   Future AddPet() async {
//     try {
//       await AddNewPet.AddPet(_usernameController.text, _accessTokenController.text);
//       print("Add pet successfully");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Inforscreen()));
//     } catch (error) {
//       _showNotification(error.toString());
//     }
//   }
//
//   void _showNotification(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Notification'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _checkFields() {
//     setState(() {
//       checkBlank = _usernameController.text.isEmpty || _accessTokenController.text.isEmpty;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Pet'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             TextField(
//               controller: _accessTokenController,
//               decoration: InputDecoration(
//                 labelText: 'Access Token',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _checkFields();
//                 if (!checkBlank) {
//                   AddPet();
//                 }
//               },
//               child: Text('Add Pet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }