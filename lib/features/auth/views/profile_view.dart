import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/data/auth_repo.dart';
import 'package:hungry_store/features/auth/data/user_model.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/shared/custom_button.dart';
import 'package:hungry_store/shared/custom_snakbar_error.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> getProfile() async {
    try {
      final user = await authRepo.getProfile();
      setState(() {
        userModel = user;
        _name.text =
            userModel?.name.toString() ?? 'Kuncles';
        _email.text = userModel?.email.toString() ??
            'Kuncles@gmail.com';
        _address.text = userModel?.address ?? 'cairo';
        _visa.text = userModel?.visa?.toString() ?? '';
      });
    } catch (e) {
      String errorMessage = 'unhandled error in Profile';
      if (e is ApiError) {
        errorMessage = e.message;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(CustomSnakBar(
            errorMessage: errorMessage) as SnackBar);
      }
    }
  }

  String? selectedImage;

  Future<void> pickphoto() async {
    final Pickedimage = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (Pickedimage != null) {
      setState(() {
        selectedImage = Pickedimage.path;
      });
    }
  }

  Future<void> updateProfile() async {
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
      });
    } catch (e) {
      String errmessage = 'Failed to load image';
      if (e is ApiError) errmessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnakBar(
              errorMessage: errmessage) as SnackBar );
    }
  }


  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: Icon(null),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          FadeInDown(
            duration: Duration(milliseconds: 400),
            child: Image.asset(
              'assets/icons/settings.png',
              color: Colors.white,
              width: 24.w,
            ),
          ),
          Gap(15),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await getProfile();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Skeletonizer(
              enabled: userModel == null,
              child: Column(
                children: [
                  FadeInDown(
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2,
                                  color: Colors.white),
                              color: Colors.grey,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(
                                    selectedImage ?? "")),
                              )

                          ),
                          clipBehavior: Clip.antiAlias,
                          child: selectedImage != null
                              ? Image.file(File(
                              selectedImage!),fit: BoxFit.cover,)
                              : (userModel?.image != null &&
                              userModel!.image!.isNotEmpty)
                              ? Image.network(userModel!
                              .image!,fit:BoxFit.cover,
                              errorBuilder: (context, err,
                                  builder) =>
                                  Icon(Icons.person))
                              :Icon(Icons.person)
                      ),

                    ),
                  ),
                  Gap(20),
                  CustomButton(height: 35,
                    width: 140,
                    text: 'Upload Photo',
                    onTap: pickphoto
                    ,
                    color: Colors.white
                    ,
                    textColor: AppColors.primaryColor
                    ,),
                  Gap(20),
                  FadeInUp(
                    duration: Duration(milliseconds: 600),
                    child: CustomUserTxtfeild(
                        controller: _name, lable: 'Name'),
                  ),
                  Gap(25),
                  FadeInUp(
                    duration: Duration(milliseconds: 700),
                    child: CustomUserTxtfeild(
                        controller: _email, lable: 'Email'),
                  ),
                  Gap(25),
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: CustomUserTxtfeild(
                      controller: _address,
                      lable: 'Address',
                    ),
                  ),
                  Gap(15),
                  FadeInUp(
                    duration: Duration(milliseconds: 900),
                    child: Divider(color: Colors.white54),
                  ),
                  Gap(25),
                  userModel?.visa == null ?
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: CustomUserTxtfeild(
                      controller: _visa,
                      keyboardType: TextInputType.number,
                      lable: 'Add Visa Card',
                    ),
                  ) :
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Material(
                      color: Color(0xffF3F4F6),
                      borderRadius: BorderRadius.circular(
                          8),
                      child: ListTile(
                        onTap: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius
                              .circular(8),
                        ),
                        tileColor: Color(0xffF3F4F6),
                        selectedTileColor: Color(
                            0xffF3F4F6),
                        hoverColor: Color(0xffF3F4F6),
                        focusColor: Color(0xffF3F4F6),
                        splashColor: Colors.transparent,

                        subtitle: Text(
                          userModel?.visa.toString() ??
                              "3685 **** **** 5455",
                          style: TextStyle(
                              color: Colors.black),
                        ),
                        contentPadding: EdgeInsets
                            .symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          'Debit card',
                          style: TextStyle(fontSize: 17,
                              color: Colors.black),
                        ),
                        leading: Image.asset(
                          'assets/icons/image 13.png',
                          width: 83,
                        ),
                        trailing: CustomText(
                          text: 'Default',
                          color: Colors.black,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  Gap(150),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: FadeInUp(
        duration: Duration(milliseconds: 1100),
        child: Container(
          height: 100.h,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceAround,
              children: [
                GestureDetector(
                  onTap: updateProfile,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                          8),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: 'Edit profile',
                          color: Colors.white,
                        ),
                        Gap(10),
                        Icon(Icons.edit,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.primaryColor),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginView(),
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'Logout',
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Gap(10),
                      Icon(
                        Icons.exit_to_app_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
