import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:hungry_store/shared/custom_textfeild.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_auth_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController =
  TextEditingController();
  TextEditingController passwordController =
  TextEditingController();
  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset('assets/logo/logo.svg'),
                  Gap(10),
                  CustomText(
                    text:
                        'Welcome Back , Discover The Fast Food',
                    color: Colors.white,
                    weight: FontWeight.bold,
                    size: 14,
                  ),
                  Gap(70),
                  CustomTextfeild(
                    hintText: 'Email Address',
                    isPassword: false,
                    controller: emailController,
                  ),
                  Gap(20),
                  CustomTextfeild(
                    hintText: 'Password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  Gap(40),
                  CustomAuthButton(
                    onTap: () {
                      if (formKey.currentState!
                          .validate()) {
                        print('valid');
                      }
                      return;
                    },
                    text: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
