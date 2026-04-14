import 'package:hungry_store/features/product/data/product_extra_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  FoodCategory({
    super.key,
    required this.selectedIndex,
    required this.category,
    this.onCategorySelected,
  });
  final int selectedIndex;
  final List<CategoryModel> category;
  final Function(int)? onCategorySelected;

  @override
  State<FoodCategory> createState() => _CategoryLlsitState();
}

class _CategoryLlsitState extends State<FoodCategory> {
late int selectedIndex;
@override
  void initState() {
    // TODO: implement initState
  selectedIndex =widget.selectedIndex;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.category.length,
              (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                if (widget.onCategorySelected != null) {
                  widget.onCategorySelected!(index);
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                    20.r,
                  ),
                  color:
                  selectedIndex == index
                      ? AppColors.primaryColor
                      : Colors.grey.shade300
                      .withOpacity(0.6),
                ),
                child: CustomText(
                  text: widget.category[index].name,
                  color:
                  selectedIndex == index
                      ? Colors.white
                      : Colors.grey.shade600,
                  weight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
