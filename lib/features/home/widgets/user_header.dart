import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

import 'package:hungry_store/features/auth/data/user_model.dart';

class UserHeader extends StatelessWidget {
  final UserModel? userModel;
  const UserHeader({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(30),
            SvgPicture.asset(
              'assets/logo/logo.svg',
              color: AppColors.primaryColor,
              height: 35.h,
            ),
            Gap(5),
            CustomText(
              text: 'Hello, ${userModel?.name ?? 'Rich Sonic'}',
              size: 18.sp,
              color: Colors.grey.shade600,
              weight: FontWeight.bold,
            ),
            Gap(10),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 30.r,
          backgroundImage: userModel?.image != null
              ? NetworkImage(userModel!.image!)
              : null,
          child: userModel?.image == null
              ? Icon(Icons.person, color: Colors.grey)
              : null,
        ),
      ],
    );
  }
}
