import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/shared/custom_auth_button.dart';
import 'package:hungry_store/shared/custom_text.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Delicious Journey',
      subtitle: 'Discover the best flavors from your favorite local restaurants delivered to your doorstep.',
      imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?q=80&w=1000&auto=format&fit=crop',
    ),
    OnboardingData(
      title: 'Healthy Choices',
      subtitle: 'Fresh ingredients and nutritious meals prepared with love by professional chefs.',
      imageUrl: 'https://images.unsplash.com/photo-1554433607-66b5efe9d304?q=80&w=1000&auto=format&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                data: _onboardingData[index],
              );
            },
          ),
          
          Positioned(
            bottom: 60.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: _currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index 
                            ? AppColors.primaryColor 
                            : AppColors.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                Gap(40.h),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: CustomAuthButton(
                    onTap: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginView()),
                        );
                      }
                    },
                    text: _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                  ),
                ),
                Gap(20.h),
                if (_currentPage < _onboardingData.length - 1)
                  FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginView()),
                        );
                      },
                      child: CustomText(
                        text: 'Skip',
                        color: Colors.black38,
                        size: 16.sp,
                        weight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Gap(48.h), // Equal spacing for the last page
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              height: 280.h,
              width: 280.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.1), width: 8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Gap(60.h),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: CustomText(
              text: data.title,
              size: 32.sp,
              weight: FontWeight.w800,
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(16.h),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: CustomText(
              text: data.subtitle,
              size: 16.sp,
              weight: FontWeight.w500,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(120.h), // Space for button and indicators
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String imageUrl;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
