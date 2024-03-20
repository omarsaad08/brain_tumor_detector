import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LinkPatient extends StatefulWidget {
  const LinkPatient({super.key});

  @override
  State<LinkPatient> createState() => _LinkPatientState();
}

class _LinkPatientState extends State<LinkPatient> {
  TextEditingController searchDoctor = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  Future<void> link() async {
    try {
      final orgNameData =
          await db.collection("userData").doc(searchDoctor.text).get();
      final orgName = await orgNameData.data()!['organizationName'];
      await db.collection("userData").doc(user.email).set({
        'doctorEmail': searchDoctor.text,
        'type': 'patient',
        'lastCheck': "Not Yet",
        'result': "Not Yet",
        'organizationName': orgName
      }, SetOptions(merge: true));
      print("done: userId = ${user.email}");
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("error caught: ${e}");
    }
  }

  Future<void> noLink() async {
    try {
      await db.collection("userData").doc(user.email).set({
        'doctorEmail': "no doctor",
        'type': 'patient',
        'lastCheck': "Not Yet",
        'result': "Not Yet",
        'organizationName': "none"
      }, SetOptions(merge: true));
      print("done: userId = ${user.email}");
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("error caught: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("What is your doctor's email?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              controller: searchDoctor,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                prefixIcon: Icon(Icons.mail),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xFFeeeeee),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: TextButton(
                  onPressed: link,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      elevation: 0.0,
                      backgroundColor: Color(0xFF222222),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: noLink,
                  child: Text(
                    "No Doctor",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      elevation: 0.0,
                      backgroundColor: Color(0xFF222222),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
