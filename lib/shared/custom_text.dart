import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.weight,
    this.size,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
  });
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? (maxLines == null ? TextOverflow.ellipsis : null),
      textAlign: textAlign,
      textScaler: TextScaler.noScaling,
      style: TextStyle(
        fontSize: size?.sp ?? 18,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
