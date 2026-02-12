
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/root.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {

  late AnimationController _logoController;
  late AnimationController _loadingController;

  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _imageSlide;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const Spacer(),

          /// LOGO
          FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: SvgPicture.asset(
                'assets/logo/logo.svg',
                height: 60.h,
                width: 60,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// LOADING INDICATOR (Custom)
          SizedBox(
            height: 24.h,
            child: AnimatedBuilder(
              animation: _loadingController,
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final value =
                        (_loadingController.value + index * 0.2) % 1.0;
                    final scale = 0.6 + (value < 0.5 ? value : 1 - value);

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          const Spacer(),

          /// IMAGE
          SlideTransition(
            position: _imageSlide,
            child: Image.asset(
              'assets/splash/image 1.png',
              height: 220.h,
            ),
          ),
        ],
      ),
    );
  }
}
