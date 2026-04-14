import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/cart/data/cart_model.dart';
import 'package:hungry_store/features/cart/data/cart_repo.dart';
import 'package:hungry_store/features/cart/widgets/cart_item.dart';
import 'package:hungry_store/features/checkout/views/checkout_view.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/shared/custom_loading.dart';
import 'package:hungry_store/core/network/api_error.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartRepo _cartRepo = CartRepo();
  List<CartModel> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    setState(() => _isLoading = true);
    try {
      final items = await _cartRepo.getCart();
      setState(() {
        _cartItems = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is ApiError ? e.message : e.toString()),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
      }
    }
  }

  double get _totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> _removeItem(int id) async {
    // Optimistic UI update: Remove item immediately
    final index = _cartItems.indexWhere((item) => item.itemId == id);
    if (index == -1) return;

    final removedItem = _cartItems[index];
    setState(() {
      _cartItems.removeAt(index);
    });

    try {
      await _cartRepo.removeFromCart(id);
      // No need to fetch all items again if successful
    } catch (e) {
      // Revert if failed
      setState(() {
        _cartItems.insert(index, removedItem);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is ApiError ? e.message : e.toString()),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: _isLoading
          ? const Center(child: CustomLoading())
          : _cartItems.isEmpty
              ? _buildEmptyCart()
              : _buildCartContent(),
    );
  }

  // ── Empty State ──────────────────────────────────────────────────────
  Widget _buildEmptyCart() {
    return Center(
      child: FadeIn(
        duration: const Duration(milliseconds: 600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 56.w,
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
            Gap(24.h),
            CustomText(
              text: 'Your cart is empty',
              size: 20.sp,
              weight: FontWeight.w700,
            ),
            Gap(8.h),
            CustomText(
              text: 'Add some delicious items to get started!',
              size: 14.sp,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }

  // ── Cart Content ─────────────────────────────────────────────────────
  Widget _buildCartContent() {
    return Stack(
      children: [
        // Scrollable List
        CustomScrollView(

          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 4.h),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'My Cart',
                            size: 28.sp,
                            weight: FontWeight.w800,
                          ),
                          Gap(4.h),
                          CustomText(
                            text: '${_cartItems.length} item${_cartItems.length > 1 ? 's' : ''}',
                            size: 14.sp,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                      // Clear all badge
                      if (_cartItems.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            // Could implement clear-all later
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete_sweep_outlined, size: 18.w, color: Colors.red.shade400),
                                Gap(4.w),
                                Text(
                                  'Clear',
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Swipe Hint ──
            SliverToBoxAdapter(
              child: FadeIn(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Icon(Icons.swipe_left_rounded, size: 16.w, color: Colors.grey.shade400),
                      Gap(6.w),
                      Text(
                        'Swipe left to remove item',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Cart Items ──
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _cartItems[index];
                    return FadeInLeft(
                      duration: Duration(milliseconds: 400 + (index * 80)),
                      child: CartItem(
                        cartItem: item,
                        onRemove: () => _removeItem(item.itemId),
                      ),
                    );
                  },
                  childCount: _cartItems.length,
                ),
              ),
            ),

            // Space for the bottom bar + nav bar
            SliverGap(350.h),
          ],
        ),

        // ── Floating Checkout Bar ──
        Positioned(
          left: 12.w,
          right: 12.w,
          bottom: 110.h,
          child: FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: Container(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag indicator
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  // Subtotal row
                  _buildPriceRow('Subtotal', '${_totalPrice.toStringAsFixed(2)} \$'),
                  Gap(8.h),
                  _buildPriceRow('Delivery', 'Free', valueColor: Colors.green.shade600),
                  Gap(12.h),

                  // Divider
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  Gap(12.h),

                  // Total row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Total',
                        size: 18.sp,
                        weight: FontWeight.w800,
                      ),
                      CustomText(
                        text: '${_totalPrice.toStringAsFixed(2)} \$',
                        size: 22.sp,
                        weight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  Gap(20.h),

                  // Checkout button
                  GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutView(
                                cartItems: _cartItems,
                                totalPrice: _totalPrice,
                              ),
                            ),
                          );
                        },
                    child: Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline_rounded, color: Colors.white, size: 20.w),
                          Gap(10.w),
                          Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Gap(8.w),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white.withOpacity(0.7), size: 20.w),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          size: 14.sp,
          color: Colors.grey.shade500,
        ),
        CustomText(
          text: value,
          size: 14.sp,
          weight: FontWeight.w600,
          color: valueColor,
        ),
      ],
    );
  }
}
