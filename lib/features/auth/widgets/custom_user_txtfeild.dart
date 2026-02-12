import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUserTxtfeild extends StatelessWidget {
  const CustomUserTxtfeild({super.key, required this.controller, required this.lable});
  final TextEditingController controller;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          labelText: lable,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)

          ) ,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)


          )
      ) ,);
  }
}
