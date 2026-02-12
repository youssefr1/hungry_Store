import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });

  final String image, text, desc, rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(

                    right: 0,
                    left: 0,
                    bottom:-10,
                    child: Image.asset('assets/icons/shadow.png',height: 45,)
                ),
                Center(
                  child: Image.asset(
                    image,
                    width: 120.w,
                    height: 120.h,
                  ),
                ),

              ],
            ),
            Gap(10),
            CustomText(text: text, weight: FontWeight.w500),
            CustomText(
              text: desc,
              weight: FontWeight.normal,
            ),
            Gap(20),
            Row(
              children: [
                CustomText(
                  text: '⭐ $rate',
                  weight: FontWeight.w500,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
