import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SerachBar extends StatelessWidget {
  const SerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(
        15.r,
      ),
      elevation: 3,

      shadowColor: Colors.grey,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.search_outlined,
          ),
          hintText: 'Search..',
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
