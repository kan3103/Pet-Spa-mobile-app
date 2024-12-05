// import 'package:flutter/material.dart';
// import 'package:frontend/homepage/customer_homepage.dart';
// import 'package:frontend/homepage/staff_homepage.dart';
// import 'package:frontend/homepage/manager_homepage.dart';
// import 'package:frontend/login_screen/login_screen.dart';
// import 'package:frontend/login_screen/component/sign_in.dart';
// import 'package:frontend/login_screen/api/token_storage.dart';
//
// class PartitionUser extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: TokenStorage.getAccountType(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           final accountType = snapshot.data;
//           if (accountType == 'customer') {
//             return customerHomePage();
//           } else if (accountType == 'staff') {
//             return staffHomePage();
//           } else if (accountType == 'manager') {
//             return managerHomePage();
//           } else {
//             return Center(child: Text('Unknown account type'));
//           }
//         } else {
//           return Center(child: Text('No account type found'));
//         }
//       },
//     );
//   }
// }