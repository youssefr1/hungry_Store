import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';

import '../../../shared/custom_auth_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textfeild.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController() ;
  TextEditingController userNameController = TextEditingController() ;
  TextEditingController confirmPasswordController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(100),
                    SvgPicture.asset('assets/logo/logo.svg'),
                    Gap(90),
                    CustomTextfeild(hintText: 'UserName', isPassword: false, controller: userNameController),
                    Gap(30),
                    CustomTextfeild(hintText: 'Email Address', isPassword: false, controller: emailController),
                    Gap(30),
                    CustomTextfeild(hintText: 'Password', isPassword: true, controller: passwordController),
                    Gap(30),
                    CustomTextfeild(hintText: 'ConfirmPassword', isPassword: true, controller: confirmPasswordController),
                    Gap(80),
                    CustomAuthButton(
                      onTap: () {
                        if (formKey.currentState!
                            .validate()) {
                          print('valid');
                        }
                        return;
                      },
                      text: 'Sign Up',
                    ),
                    Gap(40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
