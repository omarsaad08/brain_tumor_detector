import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpConfig extends StatefulWidget {
  const SignUpConfig({super.key});

  @override
  State<SignUpConfig> createState() => _SignUpConfigState();
}

class _SignUpConfigState extends State<SignUpConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Are you a .....?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/linkPatient');
              },
              child: Text(
                "Patient",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  elevation: 0.0,
                  backgroundColor: Color(0xFF222222),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orgSetup');
              },
              child: Text(
                "Doctor",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  elevation: 0.0,
                  backgroundColor: Color(0xFF222222),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ])
        ],
      ),
    ));
  }
}
