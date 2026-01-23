import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});
  final String text ;
  final  Function() onTap ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 190,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: Colors.white,
            size: 18,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
