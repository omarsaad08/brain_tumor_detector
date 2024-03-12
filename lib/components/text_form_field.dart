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
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        hintText: "  " + hintText,
        hintStyle: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Color(0xFF333333),
      ),
    );
  }
}
