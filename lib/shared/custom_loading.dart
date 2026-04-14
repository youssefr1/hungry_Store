import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hungry_store/core/constants/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final bool centered;
  final Color? color;
  final double size;

  const CustomLoading({
    super.key,
    this.centered = true,
    this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );

    if (centered) {
      return Center(child: child);
    }
    return child;
  }
}
