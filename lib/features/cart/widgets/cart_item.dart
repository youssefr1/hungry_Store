import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.disc,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.num,
  });

  final String image, text, disc;
  final Function()? onAdd;

  final Function()? onMinus;

  final Function()? onRemove;

  final int num;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(image, width: 100),
                CustomText(
                  text: text,
                  size: 16,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: disc,
                  size: 14,
                  weight: FontWeight.w300,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.primaryColor,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Gap(20),
                    CustomText(
                      text: num.toString(),
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                    Gap(20),
                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.primaryColor,
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(15),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Center(
                      child: CustomText(
                        text: 'Remove',
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
