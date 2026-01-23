import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.text, required this.desc, required this.rate});
  final String image ,text , desc , rate ;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image,width:160,),
            Gap(10),
            CustomText(text: text,weight: FontWeight.w500,),
            CustomText(text: desc,weight: FontWeight.normal,),
            Gap(20),
            Row(
              children: [
                CustomText(text: '⭐ $rate',weight: FontWeight.w500,),
                Spacer(),
                GestureDetector(onTap: (){

                },child: Icon(Icons.favorite,color: AppColors.primaryColor,))
              ],
            ),
      
      
          ],
        ),
      ),
    );
  }
}
