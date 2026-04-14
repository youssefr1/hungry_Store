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
  @override
  void initState() {
    super.initState();
  }

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
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Root()),
            );
          }
        }
      } catch (e) {
        if (mounted) Navigator.pop(context); // dismiss loading dialog
        String errorMessage = 'unhandled error in login';
        if (e is ApiError) {
          errorMessage = e.message;
        }
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                CustomDialog(type: DialogType.error, message: errorMessage),
          );
        }
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Decorative Premium Background Elements
            Positioned(
              top: -100,
              right: -100,
              child: Opacity(
                opacity: 0.03,
                child: Transform.rotate(
                  angle: -0.2,
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    height: 400.h,
                    colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -80,
              child: Opacity(
                opacity: 0.04,
                child: Container(
                  width: 300.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Gap(60.h),
                        // Premium Logo Section (Floating with Border)
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade50, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/logo/logo.svg',
                              colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                              height: 55.h,
                              width: 55.w,
                            ),
                          ),
                        ),
                        Gap(30.h),
                        SlideInLeft(
                          duration: const Duration(milliseconds: 600),
                          child: CustomText(
                            text: 'Welcome Back',
                            color: Colors.black87,
                            weight: FontWeight.w800,
                            size: 32.sp,
                          ),
                        ),
                        Gap(8.h),
                        SlideInRight(
                          duration: const Duration(milliseconds: 600),
                          child: CustomText(
                            text: 'Login to continue your flavor journey',
                            color: Colors.black54,
                            weight: FontWeight.w500,
                            size: 16.sp,
                          ),
                        ),
                        Gap(50.h),
                        
                        // Premium Form (Multi-layered Shadow Green Card)
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.25),
                                  blurRadius: 35,
                                  offset: const Offset(0, 15),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    inputDecorationTheme: InputDecorationTheme(
                                      fillColor: Colors.white.withOpacity(0.08),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.sp),
                                      prefixIconColor: Colors.white70,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18.r),
                                        borderSide: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18.r),
                                        borderSide: const BorderSide(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      CustomTextfeild(
                                        hintText: 'Email Address',
                                        isPassword: false,
                                        controller: emailController,
                                      ),
                                      Gap(20.h),
                                      CustomTextfeild(
                                        hintText: 'Password',
                                        isPassword: true,
                                        controller: passwordController,
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(10.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: CustomText(
                                      text: 'Forgot Password?',
                                      color: Colors.white.withOpacity(0.7),
                                      size: 14.sp,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Gap(30.h),
                                CustomAuthButton(
                                  color: Colors.white,
                                  textColor: AppColors.primaryColor,
                                  onTap: login,
                                  text: 'Login',
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        Gap(40.h),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Don't have an account? ",
                                color: Colors.black54,
                                size: 15.sp,
                                weight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupView()),
                                  );
                                },
                                child: CustomText(
                                  text: 'Sign Up',
                                  color: AppColors.primaryColor,
                                  weight: FontWeight.w800,
                                  size: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20.h),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Root()),
                              );
                            },
                            child: CustomText(
                              text: 'Continue as guest',
                              color: Colors.black38,
                              size: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Gap(40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
