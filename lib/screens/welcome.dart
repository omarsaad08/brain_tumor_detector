// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  List<String> homeInfo = [];
  Future<void> setupHome() async {
    final data = await db.collection("userData").doc(user.email!).get();
    if (data.data()!['type'] == 'doctor') {
      homeInfo.add(data.data()!['organizationName']);
      homeInfo.add("Patients");
      homeInfo.add(data.data()!['patientsNumber'].toString());
      homeInfo.add("Positive Cases");
      homeInfo.add(data.data()!['positiveCases'].toString());
    } else if (data.data()!['type'] == 'patient') {
      homeInfo.add(data.data()!['organizationName']);
      homeInfo.add('Last Check');
      homeInfo.add(data.data()!['lastCheck']);
      homeInfo.add("Result");
      homeInfo.add(data.data()!['result']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffafafa),
        body: FutureBuilder(
          future: setupHome(),
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
              print(homeInfo);
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF222222),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Welcome to Tumora!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken),
                        child: Image(
                          image: AssetImage("assets/home.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF222222),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "Organization",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(homeInfo[0],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28)),
                          ],
                        )),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(20),
                              child: Column(children: [
                                Text(
                                  homeInfo[1],
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(homeInfo[2],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 26))
                              ])),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF222222),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(20),
                            child: Column(children: [
                              Text(homeInfo[3],
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 8,
                              ),
                              Text(homeInfo[4],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26))
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
/*

*/