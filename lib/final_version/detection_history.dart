// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers
import 'package:brain_tumor_detector/components/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetectionHistory extends StatefulWidget {
  const DetectionHistory({super.key});

  @override
  State<DetectionHistory> createState() => _DetectionHistoryState();
}

class _DetectionHistoryState extends State<DetectionHistory> {
  TextEditingController searchController = TextEditingController();
  List<String> patients = [];
  Future fetchPatients() async {
    try {
      // retrieve all the patients names
      final collection = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .get();
      patients = collection.docs.map((e) => e.id).toList();
      patients.remove('user');
      print("document Ids: $patients");
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: fetchPatients(),
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
          return Container(
            color: Color(0xfffafafa),
            child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text("History",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff000000))),
                        SizedBox(width: 16),
                        Expanded(
                            child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          obscureText: false,
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            hintText: "Search for a patient",
                            hintStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0xFFeeeeee),
                          ),
                        ))
                      ]),
                      SizedBox(height: 40),
                      Expanded(
                        child: ListView.builder(
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/detection_result',
                                    arguments: patients[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xff222222),
                                    border: Border(
                                      left: BorderSide(
                                          color: Color(0xFFeeeeee), width: 4),
                                    )),
                                child: Text(
                                    patients[index].replaceFirst(
                                        patients[index][0],
                                        patients[index][0].toUpperCase()),
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white)),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ),
          );
        }
      },
    ));
  }
}
