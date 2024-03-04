// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

//
class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Color.fromARGB(255, 43, 55, 93)
        backgroundColor: Color.fromARGB(255, 43, 55, 93),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF344372),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Welcome to Tumora!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
                      color: Color(0xFF344372),
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
                      Text("Your Health",
                          style: TextStyle(color: Colors.white, fontSize: 28)),
                    ],
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF344372),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Text(
                            "Patients",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text("14759",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26))
                        ])),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF344372),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Text("Positive Cases",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 8,
                        ),
                        Text("9598",
                            style: TextStyle(color: Colors.white, fontSize: 26))
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
