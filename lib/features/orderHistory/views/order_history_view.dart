import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/shared/custom_button.dart';

import '../../../shared/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100,top: 10), // مساحة للـ bottomSheet
          itemCount: 3,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 500 + (index * 150)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo/image 6.png',
                              width: 100,),
                            Gap(7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'Hamburger Hamburger',weight: FontWeight.bold,),
                                CustomText(text: 'Qty : X2'),
                                CustomText(text: 'Price : 20 \$',weight: FontWeight.bold,),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: CustomButton(text: 'Re Order', onTap: (){},width: double.infinity,),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
