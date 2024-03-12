// ignore_for_file: prefer_const_constructors

import 'package:brain_tumor_detector/final_version/detection_history.dart';
import 'package:brain_tumor_detector/final_version/detection_result.dart';
import 'package:brain_tumor_detector/screens/history.dart';
import 'package:brain_tumor_detector/screens/home.dart';
import 'package:brain_tumor_detector/screens/signup.dart';
import 'package:brain_tumor_detector/screens/login_test.dart';
import 'package:brain_tumor_detector/screens/diagnose_result.dart';
import 'package:brain_tumor_detector/screens/on_boarding/on_boarding_main.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/detect_tumor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingShown = prefs.getBool('onboardingShown') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Rubik"),
    // home: FirebaseAuth.instance.currentUser == null ? Login() : Home(),
    home: onboardingShown ? login_test() : OnBoarding(),
    // home: OnBoarding(),
    routes: {
      '/on_boarding': (context) => OnBoarding(),
      '/login': (context) => Login(),
      '/detect_tumor': (context) => DetectTumor(),
      '/signup': (context) => SignUp(),
      '/home': (context) => Home(),
      '/history': (context) => History(),
      '/login_test': (context) => login_test(),
      '/diagnose_result': (context) => Result(),
      '/detection_result': (context) => DetectionResult(),
      '/detection_history': (context) => DetectionHistory()
    },
  ));
}
// main color: Color(0xFF344372)