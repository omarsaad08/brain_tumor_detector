// import 'dart:html';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

// import 'dart:convert';
// import 'dart:convert';
import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../services/database.dart';
import '../components/text_form_field.dart';

final userDB = DatabaseService(user: FirebaseAuth.instance.currentUser!);

final storage = FirebaseStorage.instance;
final storageRef = storage.ref().child("images");

class DetectTumor extends StatefulWidget {
  const DetectTumor({super.key});

  @override
  State<DetectTumor> createState() => _DetectTumorState();
}

class _DetectTumorState extends State<DetectTumor> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? selectedImage;
  Future pickImageFromGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print("done");
    setState(() {
      selectedImage = File(resultImage!.path);
    });
  }

  Future uploadImage() async {
    try {
      await userDB.detectTumor(nameController.text, emailController.text,
          '${date.day}/${date.month}/${date.year}', selectedImage);
      Navigator.pushNamed(context, '/detection_result',
          arguments: nameController.text);
      userDB.changeDoctorsPatients();
    } catch (e) {
      print("there is an error: ${e}");
      print("is doctor: ${userDB.isDoctor}");
    }
  }

  DateTime date = DateTime.now();
  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        date = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detect The Tumor",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff222222),
                            border:
                                Border.all(color: Color(0xff555555), width: 3)),
                        width: 50,
                        height: 50,
                        child: Center(
                            child: Text("1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Fill Patient's Info ", style: TextStyle(fontSize: 12))
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff222222),
                            border:
                                Border.all(color: Color(0xff555555), width: 3)),
                        width: 50,
                        height: 50,
                        child: Center(
                            child: Text("2",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Upload The MRI", style: TextStyle(fontSize: 12))
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff222222),
                            border:
                                Border.all(color: Color(0xff555555), width: 3)),
                        width: 50,
                        height: 50,
                        child: Center(
                            child: Text("3",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Get Instant Result!", style: TextStyle(fontSize: 12))
                  ]),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Text("Patient Name",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFeeeeee),
                ),
              ),
              SizedBox(height: 10),
              Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFeeeeee),
                ),
              ),
              SizedBox(height: 10),
              Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                controller: ageController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFeeeeee),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextButton(
              //       onPressed: pickDate,
              //       child: Text(
              //         "Pick image date",
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.normal),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //           padding:
              //               EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              //           elevation: 0.0,
              //           backgroundColor: Color(0xff222222),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(50))),
              //     ),
              //     Text(
              //       "${date.day}/${date.month}/${date.year}",
              //       style: TextStyle(color: Colors.black),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: pickImageFromGallery,
                    child: Text(
                      "Pick Image from Gallery",
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
                TextButton(
                  onPressed: uploadImage,
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
              ]),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              // selectedImage != null
              //     ? Text("Image Selected!")
              //     : Text("Please Select an Image",
              //         style: TextStyle(color: Colors.black)),
              // selectedImage != null
              //     ? Image.file(
              //         selectedImage!,
              //         height: 150,
              //       )
              //     : Text("Please Select an Image",
              //         style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
