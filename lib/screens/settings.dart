// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton.filled(
            child: Text(
              "Sign Out",
            ),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/login_test');
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
