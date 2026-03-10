import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/checkout/widgets/order_details.dart';
import 'package:hungry_store/shared/custom_text.dart';

import '../../../shared/custom_button.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: Duration(milliseconds: 400),
                child: CustomText(
                  text: 'Order summary',
                  size: 25,
                  weight: FontWeight.bold,
                ),
              ),
              Gap(10),
              FadeInDown(
                duration: Duration(milliseconds: 500),
                child: OrderDetails(
                  order: '18.8',
                  taxes: '1',
                  delivery: '2',
                  total: '20',
                ),
              ),
              Gap(80),
              FadeInDown(
                duration: Duration(milliseconds: 600),
                child: CustomText(
                  text: 'Payment methods',
                  size: 25,
                  weight: FontWeight.bold,
                ),
              ),
              Gap(20),

              /// Cash
              FadeInUp(
                duration: Duration(milliseconds: 700),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Cash';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tileColor: Color(0xff3C2F2F),
                  textColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  title: Text(
                    'Cash on Delivery',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Image.asset(
                    'assets/icons/dollar Background Removed 1.png',
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: 'Cash',
                    groupValue: selectedMethod,
                    onChanged: (c) {
                      setState(() {
                        selectedMethod = c!;
                      });
                    },
                  ),
                ),
              ),

              Gap(20),
              // Debit card
              FadeInUp(
                duration: Duration(milliseconds: 800),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Visa';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tileColor: Colors.blue.shade900,
                  textColor: Colors.white,
                  subtitle: Text(
                    '3685 **** **** 5455',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    'Debit card',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Image.asset(
                    'assets/icons/image 13.png',
                    width: 83,
                    color: Colors.white,
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: 'Visa',
                    groupValue: selectedMethod,
                    onChanged: (c) {
                      setState(() {
                        selectedMethod = c!;
                      });
                    },
                  ),
                ),
              ),
              Gap(5),
              FadeInUp(
                duration: Duration(milliseconds: 900),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xffEF2A39),
                      value: true,
                      onChanged: (v) {},
                    ),
                    CustomText(
                      text:
                          'Save card details for future payments',
                      size: 15,
                    ),
                  ],
                ),
              ),
              Gap(100), // Added gap for bottomsheet
            ],
          ),
        ),
      ),
      bottomSheet: FadeInUp(
        duration: Duration(milliseconds: 600),
        child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),

        height: 110,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total',
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Gap(5),
                  CustomText(
                    text: '18.19 \$',
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              CustomButton(
                text: 'Pay now',

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 200,
                              ),
                          child: Container(
                            height: 300,
                            padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors
                                      .primaryColor,
                                  radius: 40,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                Gap(10),
                                CustomText(text: 'Success ',color: AppColors.primaryColor,size: 25,),
                                CustomText(text: 'Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email. ',size: 14,color: Colors.grey,),
                                  Spacer(),
                                CustomButton(text: 'Close',width: 220, onTap: (){
                                  Navigator.pop(context);
                                })
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
