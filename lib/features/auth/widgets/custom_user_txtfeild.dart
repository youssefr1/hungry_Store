import 'package:flutter/material.dart';

class CustomUserTxtfeild extends StatelessWidget {
  const CustomUserTxtfeild({
    super.key,
    required this.controller,
    required this.lable,
    this.keyboardType,
    this.labelColor,
    this.textColor,
    this.borderColor,
  });
  final TextEditingController controller;
  final String lable;
  final TextInputType? keyboardType;
  final Color? labelColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      style: TextStyle(color: textColor ?? Colors.white),
      cursorColor: textColor ?? Colors.white,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        labelText: lable,
        labelStyle: TextStyle(color: labelColor ?? Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
