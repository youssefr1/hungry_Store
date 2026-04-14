import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/core/utils/pref_helper.dart';
import 'package:hungry_store/features/auth/views/onboarding_view.dart';
import 'package:hungry_store/root.dart';
import 'package:hungry_store/shared/custom_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _bgController;

  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.2, 0.7, curve: Curves.easeIn)),
    );

    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.2, 0.7, curve: Curves.easeOutQuart)),
    );

    _glow = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.7, 1.0, curve: Curves.easeInOut)),
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 4), () async {
      final token = await PrefHelper.getToken();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
                token != null ? const Root() : const OnboardingView(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A09),
      body: Stack(
        children: [
          // 1. Deep Midnight Gradient Backdrop
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF050A09),
                    Color(0xFF0A1F1A),
                    Color(0xFF050A09),
                  ],
                ),
              ),
            ),
          ),

          // 2. Animated Abstract Glassmorphism Shapes
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Stack(
                children: [
                  _buildBlurredShape(
                    top: -100.h + (50.h * sin(_bgController.value * 2 * pi)),
                    right: -100.w + (50.w * cos(_bgController.value * 2 * pi)),
                    color: AppColors.primaryColor.withOpacity(0.15),
                    size: 400.w,
                  ),
                  _buildBlurredShape(
                    bottom: -150.h + (80.h * cos(_bgController.value * 2 * pi)),
                    left: -150.w + (80.w * sin(_bgController.value * 2 * pi)),
                    color: const Color(0xFF1A4F43).withOpacity(0.12),
                    size: 500.w,
                  ),
                ],
              );
            },
          ),

          // 3. Faint Particle/Light Streak Layer (Simplified with Positioned dots)
          ...List.generate(15, (index) {
            return Positioned(
              top: (index * 60.h) % 800.h,
              left: (index * 40.w) % 400.w,
              child: FadeIn(
                delay: Duration(milliseconds: index * 100),
                duration: const Duration(seconds: 2),
                child: Container(
                  width: 1.5.w,
                  height: 1.5.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // 4. Centered Logo & Brand
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: _scale.value < 1.0 ? _scale : _glow,
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.2 * _fade.value * _glow.value),
                                blurRadius: 60 * _glow.value,
                                spreadRadius: 20 * _glow.value,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.05 * _fade.value),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/logo/logo.svg',
                            height: 100.h,
                            width: 100.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Gap(50.h),
                FadeInUp(
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'HUNGRY STORE',
                        color: Colors.white.withOpacity(0.9),
                        size: 16.sp,
                        weight: FontWeight.w900,
                        letterSpacing: 8,
                      ),
                      Gap(15.h),
                      Container(
                        width: 40.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                      Gap(15.h),
                      CustomText(
                        text: 'PREMIUM DINING EXPERIENCE',
                        color: Colors.white.withOpacity(0.3),
                        size: 10.sp,
                        weight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredShape({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 100,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
