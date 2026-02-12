import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/shared/custom_text.dart';

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
  @override
  void initState(){

    _name.text = 'Knuckles';
    _email.text= 'Knuckles@gmail.com';
    _address.text= 'Knuckles 1stress';
    super.initState();



  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
    appBar:   AppBar(
      scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,weight: 20.w,),
        ),
      actions: [
        Image.asset('assets/icons/settings.png',color: Colors.white,width: 24.w,),
        Gap(15)
      ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(width: 5,color: Colors.white),
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.grey,
                    image: DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFv9rKIJfzlypnR5oA1oi_sepNpnFcWh_3aw&s'))
          
                  ),
          
                ),
              ),
              Gap(30),
              CustomUserTxtfeild(controller: _name, lable: 'Name',),
              Gap(25),
              CustomUserTxtfeild(controller: _email, lable: 'Email',),
              Gap(25),
              CustomUserTxtfeild(controller: _address, lable: 'Address',),
          
              Gap(15),
              Divider(),
              Gap(25),
              ListTile(
                onTap: () {
          
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Color(0xffF3F4F6),
                textColor: Colors.white,
                subtitle: Text(
                  '3685 **** **** 5455',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: Text(
                  'Debit card',
                  style: TextStyle(fontSize: 17,color: Colors.black),
                ),
                leading: Image.asset(
                  'assets/icons/image 13.png',
                  width: 83,
                  
                ),
                trailing: CustomText(text: 'Default',color: Colors.black,size: 15.sp,)
              ),

            ],
          ),
        ),
      ),




      bottomSheet: Container(
        height: 70.h,
        decoration: BoxDecoration(
color: Colors.white

          
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Edit profile',color: Colors.white,),
                    Gap(10),
                    Icon(Icons.edit,color: Colors.white,)
                  ],
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryColor)
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Logout',color:AppColors.primaryColor,),
                    Gap(10),
                    Icon(Icons.exit_to_app_outlined,color: AppColors.primaryColor,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
