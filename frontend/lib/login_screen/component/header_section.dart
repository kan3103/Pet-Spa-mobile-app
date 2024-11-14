import 'package:flutter/material.dart';

Widget headerSection(BuildContext context) {
  return Container(
    color: Color(0xFFF49FA4), // Entire screen background color
    child: Column(
      children: [
        // Top 3/10 section with Welcome text
        Container(
          height: MediaQuery.of(context).size.height * 0.4, // Top 3 parts
          color: Color(0xFFF49FA4),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WELCOME TO',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Katibeh',
                  color: Colors.white,
                ),
              ),
              Text(
                'THE HOME\'S PET',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Katibeh',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
