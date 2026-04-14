import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import '../../../core/network/api_error.dart';
import '../../../root.dart';
import '../../../shared/custom_auth_button.dart';
import '../../../shared/custom_dialog.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textfeild.dart';
import '../data/auth_repo.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  Future<void> SignUp() async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomDialog(type: DialogType.loading),
      );
      try {
        await authRepo.signUp(
          userNameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (mounted) Navigator.pop(context); // dismiss loading dialog
        
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomDialog(type: DialogType.success, message: 'Register successful'),
          );
        }
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Root()),
          );
        }
      } catch (e) {
        if (mounted) Navigator.pop(context); // dismiss loading dialog
        String errorMessage = 'unhandled error in register';
        if (e is ApiError) {
          errorMessage = e.message;
        }
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomDialog(type: DialogType.error, message: errorMessage),
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
              top: -80,
              left: -100,
              child: Opacity(
                opacity: 0.03,
                child: Transform.rotate(
                  angle: 0.4,
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    height: 350.h,
                    colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: -60,
              child: Opacity(
                opacity: 0.04,
                child: Container(
                  width: 250.w,
                  height: 250.h,
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
                        Gap(40.h),
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
                            text: 'Create Account',
                            color: Colors.black87,
                            weight: FontWeight.w800,
                            size: 32.sp,
                          ),
                        ),
                        Gap(8.h),
                        SlideInRight(
                          duration: const Duration(milliseconds: 600),
                          child: CustomText(
                            text: 'Join the community of food lovers',
                            color: Colors.black54,
                            weight: FontWeight.w500,
                            size: 16.sp,
                          ),
                        ),
                        Gap(40.h),
                        
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
                                        hintText: 'Full Name',
                                        isPassword: false,
                                        controller: userNameController,
                                      ),
                                      Gap(20.h),
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
                                Gap(40.h),
                                CustomAuthButton(
                                  color: Colors.white,
                                  textColor: AppColors.primaryColor,
                                  onTap: SignUp,
                                  text: 'Sign Up',
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
                                text: "Already have an account? ",
                                color: Colors.black54,
                                size: 15.sp,
                                weight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginView()),
                                  );
                                },
                                child: CustomText(
                                  text: 'Login',
                                  color: AppColors.primaryColor,
                                  weight: FontWeight.w800,
                                  size: 16.sp,
                                ),
                              ),
                            ],
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


