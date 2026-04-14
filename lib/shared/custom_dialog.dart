import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/shared/custom_loading_indicator.dart';
import 'package:hungry_store/shared/custom_text.dart';

enum DialogType { loading, success, error, auth, logout }

class CustomDialog extends StatelessWidget {
  final DialogType type;
  final String? message;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialog({
    super.key,
    required this.type,
    this.message,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ZoomIn(
        duration: const Duration(milliseconds: 400),
        child: Container(
          width: 320.w,
          padding: EdgeInsets.all(25.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              Gap(20.h),
              CustomText(
                text: _getTitle(),
                size: 20.sp,
                weight: FontWeight.bold,
                color: Colors.black,
              ),
              Gap(10.h),
              CustomText(
                text: message ?? _getDefaultMessage(),
                size: 14.sp,
                weight: FontWeight.w400,
                color: Colors.grey.shade600,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              if (type != DialogType.loading) ...[
                Gap(30.h),
                _buildActions(context),
              ],
              if (type == DialogType.loading) Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (type == DialogType.loading) {
      return CustomLoadingIndicator(color: AppColors.primaryColor);
    }
    
    IconData iconData;
    Color color;
    
    switch (type) {
      case DialogType.success:
        iconData = Icons.check_circle_outline_rounded;
        color = Colors.green;
        break;
      case DialogType.error:
        iconData = Icons.error_outline_rounded;
        color = Colors.red;
        break;
      case DialogType.auth:
        iconData = Icons.lock_outline_rounded;
        color = AppColors.primaryColor;
        break;
      case DialogType.logout:
        iconData = Icons.logout_rounded;
        color = Colors.red;
        break;
      default:
        iconData = Icons.info_outline_rounded;
        color = Colors.blue;
    }

    return Container(
      height: 70.w,
      width: 70.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: color, size: 35.w),
    );
  }

  String _getTitle() {
    switch (type) {
      case DialogType.loading: return 'Processing';
      case DialogType.success: return 'Success';
      case DialogType.error: return 'Oops!';
      case DialogType.auth: return 'Security Guard';
      case DialogType.logout: return 'Logout';
    }
  }

  String _getDefaultMessage() {
    switch (type) {
      case DialogType.loading: return 'Please wait...';
      case DialogType.success: return 'Operation completed successfully';
      case DialogType.error: return 'Something went wrong';
      case DialogType.auth: return 'Please login to access this feature';
      case DialogType.logout: return 'Are you sure you want to log out?';
    }
  }

  Widget _buildActions(BuildContext context) {
    if (type == DialogType.auth || type == DialogType.logout) {
      final isLogout = type == DialogType.logout;
      return Column(
        children: [
          _buildButton(
            text: isLogout ? 'Logout' : 'Login / Sign Up',
            color: isLogout ? Colors.red : AppColors.primaryColor,
            textColor: Colors.white,
            onTap: onConfirm ??
                () {
                  Navigator.pop(context);
                  if (!isLogout) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  }
                },
          ),
          Gap(10.h),
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: CustomText(
              text: 'Maybe Later',
              color: Colors.grey.shade500,
              weight: FontWeight.w600,
              size: 14.sp,
            ),
          ),
        ],
      );
    }

    return _buildButton(
      text: 'Got it',
      color: AppColors.primaryColor,
      textColor: Colors.white,
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: text,
          color: textColor,
          weight: FontWeight.bold,
          size: 16.sp,
        ),
      ),
    );
  }
}
