import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';
import '../views/checkout_view.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order, required this.taxes, required this.delivery, required this.total});
  final String order , taxes , delivery, total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Gap(10),
        CheckoutWidjet('Order', order, false,false),
        Gap(10),
        CheckoutWidjet('Taxes',taxes, false,false),
        Gap(10),
        CheckoutWidjet('Delivery fees', delivery, false,false),
        Gap(15),
        Divider(),
        CheckoutWidjet('Total', total, true,false),
        Gap(10),
        CheckoutWidjet('Estimited delivery time : ', "15 - 30 mins", true,true),

      ],
    );
  }
}
Widget CheckoutWidjet(title, price, isBold, isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        size: isSmall ? 14 : 17,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade700,
      ),
      CustomText(
        text: '$price\$',
        size: isSmall ? 14 : 17,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade700,
      ),
    ],
  );
}