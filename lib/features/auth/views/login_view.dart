import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/auth/views/signup_view.dart';
import 'package:hungry_store/root.dart';
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
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(200),
                  SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primaryColor,height: 60.h,width: 60.w,),
                  Gap(10),
                  CustomText(
                    text:
                        'Welcome Back , Discover The Fast Food',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 14,
                  ),
                  Gap(100),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),)
        
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(40),
                            CustomTextfeild(
                              hintText: 'Email Address',
                              isPassword: false,
                              controller: emailController,
                            ),
                            Gap(15),
                            CustomTextfeild(
                              hintText: 'Password',
                              isPassword: true,
                              controller: passwordController,
                            ),
                            Gap(40),
                            CustomAuthButton(
                              color: Colors.transparent,
                              textColor: Colors.white,
                              onTap: () {
                                if (formKey.currentState!
                                    .validate()) {
                                  print('valid');
                                }
                                return;
                              },
                              text: 'Login',
                            ),
                            Gap(20),
                            CustomAuthButton(
                              color: Colors.white,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SignupView();
                                }));
                              },
                              text: 'Create Account ?',
                            ),
                            Gap(5),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Root();
                              }));
                            }, child: CustomText(text: 'Continue as guest ? ',color: Colors.white,))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
