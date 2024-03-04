// ignore_for_file: prefer_const_constructors

// ignore: unused_import
import 'package:brain_tumor_detector/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:brain_tumor_detector/services/database.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    // TODO: implement initState
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
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      child: ListView(
        children: [
          Container(
            width: 180,
            height: 180,
            child: Image.asset('assets/login-icon.jpg'),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Login',
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text(
            'Login to start using the app',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Email"),
          CustomTextForm(
              controller: email, hintText: "Enter Your Email", obsecure: false),
          SizedBox(
            height: 10,
          ),
          Text("Password"),
          CustomTextForm(
              controller: password,
              hintText: "Enter Your Password",
              obsecure: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromARGB(255, 63, 209, 139),
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
          FilledButton(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 12.0),
            ),
            onPressed: login,
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 63, 209, 139)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
          ),
          SizedBox(
            height: 5.0,
          ),
          FilledButton.icon(
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
                    Color.fromARGB(255, 63, 209, 139)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
          ),
        ],
      ),
    ));
  }
}
