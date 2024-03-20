// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obsecure;
  CustomTextForm(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Color(0xFFeeeeee),
      ),
    );
  }
}
