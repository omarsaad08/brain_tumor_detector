// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:brain_tumor_detector/final_version/detection_history.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:brain_tumor_detector/screens/history.dart';
import 'package:brain_tumor_detector/screens/welcome.dart';
import 'package:brain_tumor_detector/screens/detect_tumor.dart';
import 'package:brain_tumor_detector/screens/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> routes = [
    Welcome(),
    DetectTumor(),
    DetectionHistory(),
    SettingsScreen(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tumora", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF344372),
        automaticallyImplyLeading: false,
      ),
      body: routes.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(50),
            color: Color(0xFF344372)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: GNav(
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 22, 29, 49),
            gap: 8,
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: Icons.local_hospital, text: "Diagnose"),
              GButton(icon: Icons.history, text: "History"),
              GButton(icon: Icons.settings, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
