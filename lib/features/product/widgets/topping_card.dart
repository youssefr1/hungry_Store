import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageurl,
    required this.name,
    required this.onAdd,
    this.color,
    this.isSelected = false,
  });
  final String imageurl;
  final String name;
  final Function() onAdd;
  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              border: isSelected
                  ? Border.all(color: color ?? Colors.red, width: 2)
                  : null,
            ),
            child: Image.network(
              imageurl,
              height: 80.h,
              width: 75,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.fastfood,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? (color ?? Colors.red) : const Color(0xFF3A2F2F),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(2),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : (color ?? Colors.red),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Icon(
                      isSelected ? Icons.check : Icons.add,
                      size: 20,
                      color: isSelected ? (color ?? Colors.red) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
