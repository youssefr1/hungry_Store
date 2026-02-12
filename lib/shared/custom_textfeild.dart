import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';

class CustomTextfeild extends StatefulWidget {
  const CustomTextfeild({super.key, required this.hintText, required this.isPassword, required this.controller});
  final String hintText;
  final bool isPassword;
  final TextEditingController controller ;

  @override
  State<CustomTextfeild> createState() => _CustomTextfeildState();
}

class _CustomTextfeildState extends State<CustomTextfeild> {
  late bool _obscureText ;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }
  void _togglePassword (){
    setState(() {
      _obscureText =! _obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorHeight: 20,
      cursorColor: AppColors.primaryColor,
      validator:(value){

        if(value== null || value.isEmpty){
          return 'please fill the ${widget.hintText}';
        }
        return null;
      } ,
      decoration: InputDecoration(
        suffixIcon:widget.isPassword? GestureDetector(onTap:_togglePassword,child: Icon(Icons.remove_red_eye_rounded,color: Colors.white,)):null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.black),
        helperStyle: TextStyle(color: Colors.white),
        fillColor: Colors.white,
        filled: true,

      ),
      obscureText: _obscureText,


    );
  }
}
