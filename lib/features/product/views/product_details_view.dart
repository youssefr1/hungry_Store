import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/core/utils/pref_helper.dart';
import 'package:hungry_store/shared/custom_dialog.dart';
import 'package:hungry_store/features/checkout/views/checkout_view.dart';
import 'package:hungry_store/features/product/widgets/spicy_slider.dart';
import 'package:hungry_store/shared/custom_loading.dart';
import 'package:hungry_store/shared/custom_text.dart';
import 'package:hungry_store/core/network/api_services.dart';
import 'package:hungry_store/features/product/data/product_extra_model.dart';
import 'package:hungry_store/features/cart/data/cart_repo.dart';
import 'package:hungry_store/features/cart/data/cart_model.dart';
import 'package:hungry_store/features/home/data/product_model.dart';
import 'package:hungry_store/core/network/api_error.dart';
import '../../../shared/custom_button.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState
    extends State<ProductDetailsView> {
  double value = 0.5;
  final ApiServices _apiServices = ApiServices();
  final CartRepo _cartRepo = CartRepo();
  List<ExtraOption> _toppings = [];
  List<ExtraOption> _sides = [];
  final List<int> _selectedToppingIds = [];
  int? _selectedSideId;
  bool _isLoading = true;
  bool _isAddingToCart = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _addToCart() async {
    final token = await PrefHelper.getToken();
    if (token == null) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(type: DialogType.auth),
        );
      }
      return;
    }

    setState(() => _isAddingToCart = true);
    try {
      await _cartRepo.addToCart(
        productId: widget.product.id,
        quantity: 1, // Default quantity
        spicy: value, // From the slider
        toppingIds: _selectedToppingIds,
        sideIds: _selectedSideId != null ? [_selectedSideId!] : null,
      );
      setState(() => _isAddingToCart = false);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
            type: DialogType.success,
            message: 'Item added to cart successfully!',
          ),
        );
      }
    } catch (e) {
      setState(() => _isAddingToCart = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e is ApiError ? e.message : e.toString())),
        );
      }
    }
  }
  Future<void> _fetchData() async {
    try {
      final toppingRes = await _apiServices.get('/toppings');
      final sideRes = await _apiServices.get('/side-options');

      if (toppingRes != null && toppingRes['data'] != null) {
        _toppings = (toppingRes['data'] as List)
            .map((e) => ExtraOption.fromJson(e))
            .toList();
      }

      if (sideRes != null && sideRes['data'] != null) {
        _sides = (sideRes['data'] as List)
            .map((e) => ExtraOption.fromJson(e))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
                  child: _isLoading
                      ? const CustomLoading()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: _toppings.map((topping) {
                              final isSelected =
                                  _selectedToppingIds.contains(topping.id);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                ),
                                child: ToppingCard(
                                  imageurl: topping.image,
                                  name: topping.name,
                                  isSelected: isSelected,
                                  onAdd: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedToppingIds.remove(topping.id);
                                      } else {
                                        _selectedToppingIds.add(topping.id);
                                      }
                                    });
                                  },
                                ),
                              );
                            }).toList(),
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
                  child: _isLoading
                      ? const CustomLoading()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: _sides.map((side) {
                              final isSelected = _selectedSideId == side.id;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                ),
                                child: ToppingCard(
                                  imageurl: side.image,
                                  name: side.name,
                                  isSelected: isSelected,
                                  color: AppColors.primaryColor,
                                  onAdd: () {
                                    setState(() {
                                      _selectedSideId = side.id;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
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
        duration: const Duration(milliseconds: 800),
        child: Container(
          height: 90,
          margin: EdgeInsets.all(20.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, -5),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total Price',
                    color: Colors.grey.shade600,
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  Gap(4.h),
                  CustomText(
                    text: '${widget.product.price} \$',
                    size: 26.sp,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                children: [
                  // Add to Cart Button
                  GestureDetector(
                    onTap: _isAddingToCart ? null : _addToCart,
                    child: Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: _isAddingToCart
                          ? Padding(
                              padding: EdgeInsets.all(15.w),
                              child: const CustomLoading(size: 20),
                            )
                          : Icon(
                              Icons.shopping_basket_outlined,
                              color: AppColors.primaryColor,
                              size: 28.w,
                            ),
                    ),
                  ),
                  Gap(12.w),
                  // Checkout Button
                  CustomButton(
                    text: 'Checkout',
                    width: 150.w,
                    height: 55.h,
                    onTap: () async {
                      final token = await PrefHelper.getToken();
                      if (token == null) {
                        if (mounted) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const CustomDialog(type: DialogType.auth),
                          );
                        }
                        return;
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        final double priceValue = widget.product.price;
                        final List<CartModel> items = [
                          CartModel(
                            itemId: 0,
                            productId: widget.product.id.toInt(),
                            name: widget.product.name.toString(),
                            image: widget.product.image.toString(),
                            quantity: 1,
                            price: priceValue,
                            spicy: value.toDouble(),
                            toppings: _selectedToppingIds,
                            sideOptions: _selectedSideId != null ? [_selectedSideId!] : [],
                          )
                        ];
                        return CheckoutView(
                          cartItems: items,
                          totalPrice: priceValue,
                        );
                      }));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
