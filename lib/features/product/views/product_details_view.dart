import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/checkout/views/checkout_view.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: Duration(milliseconds: 400),
                  child: SpicySlider(
                    value: value,
                    onChanged: (double value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                ),
                Gap(50),
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: CustomText(
                    text: 'Toppings',
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                ),
                Gap(30),
                FadeInRight(
                  duration: Duration(milliseconds: 600),
                  child: SingleChildScrollView(
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
                ),
                Gap(20),
                FadeInUp(
                  duration: Duration(milliseconds: 700),
                  child: CustomText(
                    text: 'Side options',
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                ),
                Gap(30),
                FadeInRight(
                  duration: Duration(milliseconds: 800),
                  child: SingleChildScrollView(
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
                ),
                Gap(100), // Added spacing for bottom sheet
              ],
            ),
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
                text: 'Checkout',

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CheckoutView();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
