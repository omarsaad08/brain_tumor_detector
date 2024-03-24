// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfffafafa),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/c_square.png",
              height: 200.0,
            ),
            SizedBox(height: 40),
            Text(
              "Welcome to Tumora! Your AI companion for detecting brain tumors using MR images.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
