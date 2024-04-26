// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetectionResult extends StatefulWidget {
  const DetectionResult({super.key});

  @override
  State<DetectionResult> createState() => _DetectionResultState();
}

class _DetectionResultState extends State<DetectionResult> {
  String? patientName;
  Map<String, dynamic> patientData = {};
  String url = '';
  Future fetchResult() async {
    try {
      final getDocument = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc("$patientName")
          .get();
      if (getDocument.exists) {
        patientData = getDocument.data() as Map<String, dynamic>;
        final ref = FirebaseStorage.instance
            .ref()
            .child(patientData["segmentationPath"]);
        url = await ref.getDownloadURL();
        print('Document data: $patientData');
      } else {
        print('Document does NOT exist');
      }
    } catch (e) {
      print("error caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    patientName = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        body: FutureBuilder(
      future: fetchResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Color(0xfffafafa),
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff000000),
              ),
            ),
          );
        } else {
          List<Widget> data = [
            Container(
              child: Column(
                children: [
                  Text("Classification: ${patientData['result']}",
                      style: TextStyle(fontSize: 26, color: Colors.white)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Next Appointment: 18/4/2024",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "ebGaramond",
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              child: Image.network(url, fit: BoxFit.cover),
            ),
            Container(
                child: Column(
              children: [
                Text("Doctor's Notes:",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "ebGaramond"))
              ],
            )),
          ];
          return Container(
            color: Color(0xfffafafa),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF222222),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Result",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  size: 36,
                                  color: Color(0xFFFFFFFF),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF222222),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$patientName",
                                style: TextStyle(
                                    fontSize: 34, color: Colors.white)),
                            Text("${patientData['Diagnose Date']}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "ebGaramond",
                                    color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            // height: 100,
                            width: 280,
                            decoration: BoxDecoration(
                                color: Color(0xFF222222),
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: data[index],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        }
      },
    ));
  }
}
