import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgSetup extends StatefulWidget {
  const OrgSetup({super.key});

  @override
  State<OrgSetup> createState() => _OrgSetupState();
}

class _OrgSetupState extends State<OrgSetup> {
  TextEditingController orgNameController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  Future<void> setupOrganization() async {
    await db.collection("userData").doc(user.email).set({
      'organizationName': orgNameController.text,
      'type': 'doctor',
      'patientsNumber': 0,
      'positiveCases': 0,
      'uid': user.uid
    }, SetOptions(merge: true));
    print("done: userId = ${user}");
    Navigator.pushNamed(context, '/home');
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
          Text("What is the name of your organization?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            obscureText: false,
            controller: orgNameController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              prefixIcon: Icon(Icons.home),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFeeeeee),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: setupOrganization,
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
            ],
          )
        ],
      ),
    ));
  }
}
