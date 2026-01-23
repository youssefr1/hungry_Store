import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/product/widgets/spicy_slider.dart';
import 'package:hungry_store/shared/custom_text.dart';
import '../../../shared/custom_button.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState
    extends State<ProductDetailsView> {
  double value = 0.5;

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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: value,
                onChanged: (double value) {
                  setState(() {
                    this.value = value;
                  });
                },
              ),
              Gap(40),
              CustomText(
                text: 'Toppings',
                size: 20,
                weight: FontWeight.w600,
              ),
              Gap(30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                      child: ToppingCard(
                        imageurl:
                            'assets/logo/pngwing 15.png',
                        name: 'Tomatoo',
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(20),
              CustomText(
                text: 'Side options',
                size: 20,
                weight: FontWeight.w600,
              ),
              Gap(30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                      child: ToppingCard(
                        imageurl:
                            'assets/logo/image 14.png',
                        name: 'Fries',
                        onAdd: () {},
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
                ),
              ),
              Gap(40),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                    text: 'Add To Card',
                    onTap: () {},
                  ),
                ],
              ),
              Gap(35)
            ],
          ),
        ),
      ),
    );
  }
}
