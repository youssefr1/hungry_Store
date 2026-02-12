import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';

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
        body: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Gap(150),
                  SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primaryColor,height: 60.h,width: 60),
                  CustomText(text: 'Welcome To Our Food App'),
                  Gap(90),
                 Expanded(
                   child: Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: AppColors.primaryColor,
                       borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                     ),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           Gap(40),
                           CustomTextfeild(hintText: 'Name', isPassword: false, controller: userNameController),
                           Gap(15),
                           CustomTextfeild(hintText: 'Email Address', isPassword: false, controller: emailController),
                           Gap(15),
                           CustomTextfeild(hintText: 'Password', isPassword: true, controller: passwordController),
                       
                           Gap(40),
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
                           Gap(20),
                           CustomAuthButton(
                             textColor: Colors.white,
                             color: Colors.transparent,
                             onTap: () {

                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return LoginView();
                             }));
                             },
                             text: 'Go to login',
                           ),
                       
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
