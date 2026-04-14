import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/checkout/widgets/order_details.dart';
import 'package:hungry_store/shared/custom_text.dart';

import '../../../shared/custom_button.dart';

import 'package:hungry_store/features/cart/data/cart_model.dart';
import 'package:hungry_store/features/checkout/data/order_repo.dart';
import 'package:hungry_store/core/network/api_error.dart';

class CheckoutView extends StatefulWidget {
  final List<CartModel> cartItems;
  final double totalPrice;
  const CheckoutView({super.key, required this.cartItems, required this.totalPrice});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  bool _isProcessing = false;
  final OrderRepo _orderRepo = OrderRepo();

  Future<void> _handlePayment() async {
    setState(() => _isProcessing = true);
    try {
      await _orderRepo.placeOrder(widget.cartItems);
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                height: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 35,
                      child: Icon(Icons.check, color: Colors.white, size: 40),
                    ),
                    Gap(16),
                    CustomText(text: 'Success', color: AppColors.primaryColor, size: 24, weight: FontWeight.bold),
                    Gap(8),
                    CustomText(
                      text: 'Order placed successfully!\nYour meal is being prepared.',
                      size: 14,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    CustomButton(
                      text: 'Back to Home',
                      onTap: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is ApiError ? e.message : 'Order failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

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
                  order: widget.totalPrice.toStringAsFixed(2),
                  taxes: '0.00',
                  delivery: 'Free',
                  total: widget.totalPrice.toStringAsFixed(2),
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
                    text: '${widget.totalPrice.toStringAsFixed(2)} \$',
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              CustomButton(
                text: _isProcessing ? 'Processing...' : 'Pay now',
                onTap: _isProcessing ? () {} : () => _handlePayment(),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
