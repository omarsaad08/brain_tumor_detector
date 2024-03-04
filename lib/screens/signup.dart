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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registered Successfuly")));
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print(e);
    }
    // Navigator.pushNamed(context, '/home');
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final cred = await FirebaseAuth.instance.signInWithCredential(credential);

      print(cred);
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print("error caught: $e");
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color(0xFF344372),
                  Color.fromARGB(255, 75, 97, 165),
                  Color.fromARGB(255, 89, 116, 197),
                  Color.fromARGB(255, 131, 160, 247),
                ],
                end: Alignment.bottomRight)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 36)),
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
                      CustomTextForm(
                          controller: email,
                          hintText: "Enter Your Email",
                          obsecure: false),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Password"),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextForm(
                          controller: password,
                          hintText: "Enter Your Password",
                          obsecure: true),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Password Confirmation"),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextForm(
                          controller: password,
                          hintText: "Enter Your Password",
                          obsecure: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xFF344372),
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login_test');
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
                            "Sign Up!",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          onPressed: register,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF344372)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: FilledButton.icon(
                          label: Text(
                            "Login with Google",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          icon: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/google-icon.png')),
                          onPressed: signInWithGoogle,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF344372)),
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
