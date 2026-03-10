import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'custom_text.dart';

class CustomSnakBar extends StatelessWidget {
  const CustomSnakBar({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        margin: EdgeInsets.only(bottom: 20,right: 20,left: 20),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        backgroundColor: Colors.red.shade900,
        content: Row(
          children: [
            Icon(Icons.error,color: Colors.white,),
            Gap(10),
            CustomText(text: errorMessage,color: Colors.white,size: 16,weight: FontWeight.w400,),
          ],
        ));
  }
}