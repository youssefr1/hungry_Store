import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/shared/custom_text.dart';

import 'package:hungry_store/features/checkout/data/order_model.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderModel order;
  const OrderHistoryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Order #${order.id}', weight: FontWeight.bold, size: 16.sp),
                  CustomText(
                    text: order.date,
                    size: 12.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: order.status.toLowerCase() == 'delivered' 
                      ? Colors.green.shade50 
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CustomText(
                  text: order.status, 
                  color: order.status.toLowerCase() == 'delivered' ? Colors.green : Colors.orange, 
                  size: 12.sp, 
                  weight: FontWeight.bold
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          
          // Items Preview
          Row(
            children: [
              if (order.items.isNotEmpty)
                _buildItemThumbnail(order.items.first.image)
              else
                _buildItemThumbnail(''), // Placeholder
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: order.items.isNotEmpty ? order.items.first.name : 'No items', 
                      size: 14.sp, 
                      weight: FontWeight.w600
                    ),
                    if (order.items.length > 1)
                      CustomText(
                        text: 'And ${order.items.length - 1} other items', 
                        size: 12.sp, 
                        color: Colors.grey
                      ),
                  ],
                ),
              ),
              CustomText(
                text: '\$${order.totalPrice}', 
                size: 16.sp, 
                weight: FontWeight.bold, 
                color: AppColors.primaryColor
              ),
            ],
          ),
          Gap(20.h),
          
          // Actions
          GestureDetector(
            onTap: () {}, // TODO: Implement Re-order
            child: Container(
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh_rounded, color: AppColors.primaryColor, size: 18.w),
                    Gap(8.w),
                    CustomText(text: 'Re-order', color: AppColors.primaryColor, weight: FontWeight.bold),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemThumbnail(String image) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: image.isNotEmpty 
          ? Image.network(
              image, 
              width: 50.w, 
              height: 50.w, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.fastfood, color: Colors.grey, size: 24.w),
            )
          : Icon(Icons.fastfood, color: Colors.grey, size: 24.w),
      ),
    );
  }
}
