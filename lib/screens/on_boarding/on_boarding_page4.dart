// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPage4 extends StatelessWidget {
  OnBoardingPage4({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF344372),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/on_boarding5.svg',
              width: 200, // Specify width
              height: 200, // Specify Apply color if needed
            ),
            SizedBox(height: 40),
            Text(
              "Keep track of your organization's diagnoses and checks",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
