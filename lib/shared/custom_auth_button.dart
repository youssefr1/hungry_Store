import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.onTap, required this.text, this.color, this.textColor});
  final void Function() onTap ;
  final String text ;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.r),
          color: color ?? Colors.white,
        ),
        child:Center(child: CustomText(size: 20.sp,text: text,color:textColor?? AppColors.primaryColor,weight: FontWeight.w700,)),
      ),
    );
  }
}
