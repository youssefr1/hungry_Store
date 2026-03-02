import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text,  this.color,  this.weight,  this.size});
  final String  text ;
  final Color? color ;
  final FontWeight? weight ;
  final double? size ;

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.noScaling,
      style: TextStyle(
        fontSize: size?.sp??18,
        color:color??Colors.black,
        fontWeight: weight ??FontWeight.normal ,
      ),
    );
  }
}
