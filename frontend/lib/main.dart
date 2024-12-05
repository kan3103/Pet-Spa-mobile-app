import 'package:flutter/material.dart';
import 'package:frontend/startedpage/started_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF49FA4),),
        useMaterial3: true,
      ),
      home: GetStartedPage(),// giao dien chinh
    );
  }
}
