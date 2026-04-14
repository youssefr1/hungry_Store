import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'custom_text.dart';

class CustomSnakBar extends SnackBar {
  CustomSnakBar({
    super.key,
    required String errorMessage,
  }) : super(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
          behavior: SnackBarBehavior.floating,
          elevation: 10,
          backgroundColor: Colors.red.shade900,
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
              ),
              const Gap(10),
              CustomText(
                text: errorMessage,
                color: Colors.white,
                size: 16,
                weight: FontWeight.w400,
              ),
            ],
          ),
        );
}