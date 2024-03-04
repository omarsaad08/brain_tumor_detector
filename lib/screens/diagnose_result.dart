// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List patient = [];
  final db = FirebaseFirestore.instance;
  Future<void> getResult() async {
    final docRef = db.collection(FirebaseAuth.instance.currentUser!.uid);
    await docRef.get().then((querySnapshot) async {
      for (var docSnapshot in querySnapshot.docs) {
        if (docSnapshot.id == "firebaseTest") {
          patient.add([
            docSnapshot.id,
            docSnapshot.data()['Diagnose Date'],
            docSnapshot.data()['result']
          ]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getResult(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 63, 209, 139),
              ),
            );
          } else {
            return Column(
              children: [
                Text("name: ${patient[0]}"),
                Text("diagnose Date: ${patient[1]}"),
                Text("result: ${patient[2]}")
              ],
            );
          }
        },
      ),
    );
  }
}
