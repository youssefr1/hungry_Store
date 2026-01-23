import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.onTap, required this.text});
  final void Function() onTap ;
  final String text ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child:Center(child: CustomText(size: 20.sp,text: text,color: AppColors.primaryColor,weight: FontWeight.w700,)),
      ),
    );
  }
}
