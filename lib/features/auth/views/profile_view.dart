import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/data/auth_repo.dart';
import 'package:hungry_store/features/auth/data/user_model.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/shared/custom_dialog.dart';
import 'package:hungry_store/shared/custom_snakbar_error.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hungry_store/shared/custom_loading.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/network/api_error.dart';
import '../widgets/custom_user_txtfeild.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  bool isUpdating = false;

  Future<void> getProfile() async {
    try {
      final user = await authRepo.getProfile();
      setState(() {
        userModel = user;
        selectedImage = null; // Clear local selection to show remote image
        _name.text = userModel?.name.toString() ?? 'Kuncles';
        _email.text = userModel?.email.toString() ?? 'Kuncles@gmail.com';
        _address.text = userModel?.address ?? 'cairo';
        _visa.text = userModel?.visa?.toString() ?? '';
      });
    } catch (e) {
      String errorMessage = 'unhandled error in Profile';
      if (e is ApiError) {
        errorMessage = e.message;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnakBar(errorMessage: errorMessage));
      }
    }
  }

  String? selectedImage;

  Future<void> pickphoto() async {
    final Pickedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (Pickedimage != null) {
      setState(() {
        selectedImage = Pickedimage.path;
      });
      // Automatically upload the image to the backend
      await updateProfile();
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isUpdating = true;
    });
    try {
      final user = await authRepo.updateProfile(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        visa: _visa.text.trim(),
        image: selectedImage,
      );
      setState(() {
        userModel = user;
        selectedImage = null; // Clear local selection to show remote image
        isUpdating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      setState(() {
        isUpdating = false;
      });
      String errmessage = 'Failed to update profile';
      if (e is ApiError) errmessage = e.message;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnakBar(errorMessage: errmessage));
    }
  }

  Future<void> logout() async {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        type: DialogType.logout,
        onConfirm: () async {
          Navigator.pop(context); // close dialog
          await authRepo.logout();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: CustomScrollView(
        slivers: [
          // Premium Header
          SliverAppBar(
            expandedHeight: 220.h,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primaryColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(40.h),
                      FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child: Stack(
                          children: [
                            Container(
                              width: 110.w,
                              height: 110.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: _buildProfileImage(),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: pickphoto,
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: AppColors.primaryColor,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: CustomText(
                          text: userModel?.name ?? 'Hungry User',
                          color: Colors.white,
                          weight: FontWeight.bold,
                          size: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Skeletonizer(
                        enabled: userModel == null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              title: 'Personal Information',
                              children: [
                                CustomUserTxtfeild(
                                  controller: _name,
                                  lable: 'Full Name',
                                  textColor: Colors.black87,
                                  labelColor: Colors.grey,
                                  borderColor: Colors.grey.shade300,
                                ),
                                Gap(15.h),
                                CustomUserTxtfeild(
                                  controller: _email,
                                  lable: 'Email Address',
                                  textColor: Colors.black87,
                                  labelColor: Colors.grey,
                                  borderColor: Colors.grey.shade300,
                                ),
                                Gap(15.h),
                                CustomUserTxtfeild(
                                  controller: _address,
                                  lable: 'Delivery Address',
                                  textColor: Colors.black87,
                                  labelColor: Colors.grey,
                                  borderColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                            Gap(25.h),
                            _buildInfoSection(
                              title: 'Payment Methods',
                              children: [
                                userModel?.visa == null
                                    ? CustomUserTxtfeild(
                                        controller: _visa,
                                        keyboardType: TextInputType.number,
                                        lable: 'Link Visa Card',
                                        textColor: Colors.black87,
                                        labelColor: Colors.grey,
                                        borderColor: Colors.grey.shade300,
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(15.w),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(15.r),
                                          border: Border.all(color: Colors.grey.shade200),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset('assets/icons/image 13.png', width: 40.w),
                                            Gap(15.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: 'Debit Card', size: 14.sp, weight: FontWeight.w600),
                                                  CustomText(
                                                    text: userModel?.visa.toString() ?? "**** **** **** ****",
                                                    size: 12.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(Icons.check_circle, color: Colors.green),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(30.h),
                  
                  // Action Buttons
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: updateProfile,
                            child: Container(
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: isUpdating
                                    ? const CustomLoading(
                                        color: Colors.white,
                                        size: 20,
                                        centered: false,
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.check_circle_outline, color: Colors.white),
                                          Gap(10.w),
                                          CustomText(text: 'Save Changes', color: Colors.white, weight: FontWeight.bold),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Gap(15.w),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: logout,
                            child: Container(
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: const Center(
                                child: Icon(Icons.logout_rounded, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(120.h), // Extra space for floating nav bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (selectedImage != null) {
      return Image.file(File(selectedImage!), fit: BoxFit.cover);
    }
    if (userModel?.image != null && userModel!.image!.isNotEmpty) {
      return Image.network(
        userModel!.image!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CustomLoading(size: 20);
        },
        errorBuilder: (context, err, builder) => const Icon(Icons.person, size: 50, color: Colors.grey),
      );
    }
    return const Icon(Icons.person, size: 50, color: Colors.grey);
  }

  Widget _buildInfoSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          size: 16.sp,
          weight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        Gap(15.h),
        ...children,
      ],
    );
  }
}
