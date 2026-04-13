import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap, this.width, this.color, this.textColor, this.height});
  final String text ;
  final double? width ;
  final  Function() onTap ;
  final Color? color;
  final Color? textColor;
  final double? height ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height??60,
        width: width ?? 190 ,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: textColor?? Colors.white,
            size: 18,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
