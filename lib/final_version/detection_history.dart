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
            color: Color(0xff222222),
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff06C892),
              ),
            ),
          );
        } else {
          return Container(
            color: Color(0xff222222),
            child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF06C892),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("History",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.exit_to_app,
                                    size: 36,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextForm(
                          controller: searchController,
                          hintText: "Search for a patient",
                          obsecure: false),
                      SizedBox(height: 40),
                      Expanded(
                        child: ListView.builder(
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // from here u should Navigate to the result of the patient
                                Navigator.pushNamed(
                                    context, '/detection_result',
                                    // send the document id for the "tapped document"
                                    arguments: patients[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xff5383FF),
                                    border: Border(
                                      left: BorderSide(
                                          color: Color(0xFFDBDBDB), width: 4),
                                    )),
                                child: Text(patients[index],
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
