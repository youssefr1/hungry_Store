import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/cart/widgets/cart_item.dart';
import 'package:hungry_store/features/checkout/views/checkout_view.dart';
import 'package:hungry_store/shared/custom_button.dart';
import 'package:hungry_store/shared/custom_text.dart';

import '../../../core/constants/app_colors.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
   late List<int>  quantities ;
   int itemCount = 3 ;
   @override
  void initState() {
    quantities = List.generate(5, (_)=>1);
    super.initState();
  }
   void onAdd(int index){
     setState(() {
       quantities[index]++;
     });
   } void onMinus( int index){
     setState(() {
       if(quantities[index]>1){
         quantities[index] --;
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,),
      bottomSheet: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 20,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100,top: 40), // مساحة للـ bottomSheet
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return  CartItem(
              image: 'assets/logo/image 6.png',
              text: 'Hamburger',
              disc: 'Veggie Burger',
              num: quantities[index],
              onAdd:() => onAdd(index),
              onMinus: () =>onMinus(index)
              ,

            );
          },
        ),
      ),
    );
  }
}
