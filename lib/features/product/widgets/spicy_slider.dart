import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
final double value ;
final ValueChanged <double> onChanged ;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/logo/pngwing 12.png',height: 240.sp,),
        Spacer(),

        Column(
          children: [
            CustomText(text: 'Customize Your Burger\n to Your Tastes. \nUltimate Experience' ),
            SizedBox(
              width: 220.w,
              child: Slider(
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.grey.shade300,
                  min: 0,
                  max: 1,
                  value: widget.value   ,
                  onChanged: widget.onChanged  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: '🥶'),
                Gap(140.w),
                CustomText(text: '🌶️'),
              ],
            )
          ],
        )
      ],
    );
  }
}
