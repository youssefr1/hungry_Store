import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:hungry_store/features/cart/data/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
    this.onRemove,
  });

  final CartModel cartItem;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.itemId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove?.call(),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade300, Colors.red.shade600],
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28.w),
            Gap(4.h),
            Text('Remove', style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey.shade100, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor.withOpacity(0.05),
                    AppColors.primaryColor.withOpacity(0.12),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  cartItem.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.fastfood_rounded,
                    size: 36.w,
                    color: AppColors.primaryColor.withOpacity(0.4),
                  ),
                ),
              ),
            ),
            Gap(14.w),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: cartItem.name,
                    size: 15.sp,
                    weight: FontWeight.w700,
                    maxLines: 1,
                  ),
                  Gap(4.h),
                  if (cartItem.spicy > 0)
                    Row(
                      children: [
                        Icon(Icons.local_fire_department_rounded, size: 14.w, color: Colors.orange),
                        Gap(4.w),
                        CustomText(
                          text: 'Spicy: ${(cartItem.spicy * 100).toInt()}%',
                          size: 12.sp,
                          color: Colors.orange.shade700,
                        ),
                      ],
                    ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CustomText(
                          text: '${cartItem.price} \$',
                          size: 14.sp,
                          weight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      // Quantity
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: 'Qty: ',
                              size: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                            CustomText(
                              text: cartItem.quantity.toString(),
                              size: 14.sp,
                              weight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
