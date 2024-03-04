// ignore_for_file: prefer_const_constructors

import 'package:brain_tumor_detector/screens/on_boarding/on_boarding_page1.dart';
import 'package:brain_tumor_detector/screens/on_boarding/on_boarding_page2.dart';
import 'package:brain_tumor_detector/screens/on_boarding/on_boarding_page3.dart';
import 'package:brain_tumor_detector/screens/on_boarding/on_boarding_page4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          children: [
            OnBoardingPage1(),
            OnBoardingPage2(),
            OnBoardingPage3(),
            OnBoardingPage4(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text("skip", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    controller.jumpToPage(3);
                  },
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: ExpandingDotsEffect(),
                ),
                (onLastPage)
                    ? GestureDetector(
                        child:
                            Text("done", style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          Navigator.pushNamed(context, "/login_test");
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('onboardingShown', true);
                        })
                    : GestureDetector(
                        child:
                            Text("next", style: TextStyle(color: Colors.white)),
                        onTap: () {
                          controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }),
              ],
            )),
      ],
    ));
  }
}
