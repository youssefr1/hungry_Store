import 'package:flutter/material.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/shared/custom_loading_indicator.dart';
import 'package:gap/gap.dart';

enum DialogType { loading, success, error }

class CustomDialog extends StatelessWidget {
  final DialogType type;
  final String? message;

  const CustomDialog({super.key, required this.type, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          height: 250,
          width:250,
          constraints: const BoxConstraints(
            minHeight: 100,
            minWidth: 70,
            maxWidth: 280,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (type == DialogType.loading) ...[
                CustomLoadingIndicator(color: AppColors.primaryColor),
                const Gap(20),
                Text(
                  message ?? 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else if (type == DialogType.success) ...[
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(Icons.check, color: Colors.white, size: 30),
                ),
                const Gap(20),
                Flexible(
                  child: Text(
                    message ?? 'Success!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else if (type == DialogType.error) ...[
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: Icon(Icons.close, color: Colors.white, size: 30),
                ),
                const Gap(20),
                Flexible(
                  child: Text(
                    message ?? 'Error!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
