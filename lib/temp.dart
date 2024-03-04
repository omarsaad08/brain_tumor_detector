// ignore_for_file: prefer_const_constructors, sort_child_properties_last

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
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              width: 130,
              height: 130,
              child: Image.asset('assets/login-icon.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Sign Up',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
            Text(
              'Sign Up to start using the app',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Email"),
            CustomTextForm(
                controller: email,
                hintText: "Enter Your Email",
                obsecure: false),
            SizedBox(
              height: 10,
            ),
            Text("Password "),
            CustomTextForm(
                controller: password,
                hintText: "Enter Your Password",
                obsecure: true),
            SizedBox(
              height: 10,
            ),
            Text("Password Confirmation"),
            CustomTextForm(
                controller: passwordConfirmation,
                hintText: "Enter Your Password Again",
                obsecure: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 63, 209, 139),
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
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
                "Sign Up!",
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: register,
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
      ),
    ));
  }
}
