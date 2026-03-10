import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingIndicator extends StatefulWidget {
  final Color color;
  const CustomLoadingIndicator({super.key, this.color = Colors.white});

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: AnimatedBuilder(
        animation: _loadingController,
        builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final value = (_loadingController.value + index * 0.2) % 1.0;
              final scale = 0.6 + (value < 0.5 ? value : 1 - value);

              return Transform.scale(
                scale: scale,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
