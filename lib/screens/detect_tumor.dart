// import 'dart:html';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

// import 'dart:convert';
// import 'dart:convert';
import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';
import '../services/database.dart';
import '../components/text_form_field.dart';

final storage = FirebaseStorage.instance;
final storageRef = storage.ref().child("images");

class DetectTumor extends StatefulWidget {
  const DetectTumor({super.key});

  @override
  State<DetectTumor> createState() => _DetectTumorState();
}

class _DetectTumorState extends State<DetectTumor> {
  TextEditingController nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
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
    storageRef
        .child("${user!.uid}-${nameController.text}.jpg")
        .putFile(selectedImage!);
    print("photo sent");
    var formData = FormData.fromMap(
        {'path': 'images/${user!.uid}-${nameController.text}.jpg'});
    if (nameController.text != '') {
      try {
        print("tryinggggg");
        Response response = await Dio().post(
            "https://tumordetector-fbcf91d4acbc.herokuapp.com/submit_path",
            data: formData);
        print(response.data['prediction']);
        print(response.data['FireBasePath']);
        final userDatabase = DatabaseService(uid: user?.uid);
        userDatabase.updateUserData(
            nameController.text,
            "${date.day}/${date.month}/${date.year}",
            response.data['prediction']);
      } catch (e) {
        print("error caught yasta: $e");
      }
    } else if (selectedImage != null) {
      print("please select the MR image");
    } else {
      print("please enter a name and a date");
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
      backgroundColor: Color.fromARGB(255, 43, 55, 93),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Detect the Tumor",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextForm(
                  controller: nameController,
                  hintText: "Patient Name",
                  obsecure: false),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: pickDate,
                    child: Text(
                      "Pick a date",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        elevation: 0.0,
                        backgroundColor: Color(0xFF344372),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  Text(
                    "${date.day}/${date.month}/${date.year}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: pickImageFromGallery,
                child: Text(
                  "Pick MR Image from Gallery",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    elevation: 0.0,
                    backgroundColor: Color(0xFF344372),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 10.0,
              ),
              selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      height: 150,
                    )
                  : Text("Please Select an Image",
                      style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: uploadImage,
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    elevation: 0.0,
                    backgroundColor: Color(0xFF344372),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
