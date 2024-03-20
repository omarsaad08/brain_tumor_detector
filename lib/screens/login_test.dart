// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/text_form_field.dart';
import 'package:brain_tumor_detector/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login_test extends StatefulWidget {
  const login_test({super.key});

  @override
  State<login_test> createState() => _login_testState();
}

class _login_testState extends State<login_test> {
  List<QueryDocumentSnapshot> data = [];
  dynamic db = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final cred = await FirebaseAuth.instance.signInWithCredential(credential);
      print(cred.user?.uid);
      final uid = cred.user?.uid;
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("error caught: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xff222222),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         colors: [
        //           Color(0xFF344372),
        //           Color.fromARGB(255, 75, 97, 165),
        //           Color.fromARGB(255, 89, 116, 197),
        //           Color.fromARGB(255, 131, 160, 247),
        //         ],
        //         end: Alignment.bottomRight)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            child: Image(
                                image: AssetImage("assets/brain.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      Text("Email"),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        controller: email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Color(0xFFeeeeee),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Password"),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          prefixIcon: Icon(Icons.key_sharp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Color(0xFFeeeeee),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                          ),
                          TextButton(
                            child: Text("Forget Password ?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0)),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: FilledButton(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: login,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF222222)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
