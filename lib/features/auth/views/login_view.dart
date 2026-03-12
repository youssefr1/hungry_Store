import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/auth/data/auth_repo.dart';
import 'package:hungry_store/features/auth/views/signup_view.dart';
import 'package:hungry_store/root.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:hungry_store/shared/custom_textfeild.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_auth_button.dart';
import '../../../shared/custom_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomDialog(type: DialogType.loading),
      );
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        Navigator.pop(context); // dismiss loading dialog
        if (user != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomDialog(
              type: DialogType.success,
              message: 'Login successful',
            ),
          );
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Root();
              },
            ),
          );
        }
      } catch (e) {
        Navigator.pop(context); // dismiss loading dialog
        String errorMessage = 'unhandled error in login';
        if (e is ApiError) {
          errorMessage = e.message;
        }
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              CustomDialog(type: DialogType.error, message: errorMessage),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(140.h),
                    FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: SvgPicture.asset(
                        'assets/logo/logo.svg',
                        color: AppColors.primaryColor,
                        height: 70.h,
                        width: 70.w,
                      ),
                    ),
                    Gap(20.h),
                    FadeInDown(
                      duration: Duration(milliseconds: 600),
                      child: CustomText(
                        text: 'Welcome Back!',
                        color: Colors.black,
                        weight: FontWeight.bold,
                        size: 26.sp,
                      ),
                    ),
                    Gap(5.h),
                    FadeInDown(
                      duration: Duration(milliseconds: 700),
                      child: CustomText(
                        text: 'Discover The Best Fast Food',
                        color: Colors.grey.shade600,
                        weight: FontWeight.w500,
                        size: 14.sp,
                      ),
                    ),
                    Gap(80.h),
                    Expanded(
                      child: FadeInUp(
                        duration: Duration(milliseconds: 800),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.r),
                              topLeft: Radius.circular(40.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Gap(40.h),
                                FadeInUp(
                                  duration: Duration(milliseconds: 900),
                                  child: CustomTextfeild(
                                    hintText: 'Email Address',
                                    isPassword: false,
                                    controller: emailController,
                                  ),
                                ),
                                Gap(20.h),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1000),
                                  child: CustomTextfeild(
                                    hintText: 'Password',
                                    isPassword: true,
                                    controller: passwordController,
                                  ),
                                ),
                                Gap(40.h),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1100),
                                  child: CustomAuthButton(
                                    color: Colors.white,
                                    textColor: AppColors.primaryColor,
                                    onTap: login,
                                    text: 'Login',
                                  ),
                                ),
                                Gap(20.h),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1200),
                                  child: CustomAuthButton(
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SignupView();
                                          },
                                        ),
                                      );
                                    },
                                    text: 'Create Account',
                                  ),
                                ),
                                Gap(10.h),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1300),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Root();
                                          },
                                        ),
                                      );
                                    },
                                    child: CustomText(
                                      text: 'Continue as guest',
                                      color: Colors.white70,
                                      size: 15.sp,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
