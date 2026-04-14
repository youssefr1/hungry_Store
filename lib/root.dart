import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hungry_store/core/utils/pref_helper.dart';
import 'package:hungry_store/shared/custom_dialog.dart';
import 'package:hungry_store/shared/custom_animated_nav_bar.dart';

import 'features/auth/views/profile_view.dart';
import 'features/cart/views/cart_view.dart';
import 'features/home/views/home_view.dart';
import 'features/orderHistory/views/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController pageController;
  late List<Widget> screens;
  int currentScreen = 0;

  @override
  void initState() {
    screens = [
      const HomeView(),
      const CartView(),
      const OrderHistoryView(),
      const ProfileView(),
    ];
    pageController = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true, // Allow body to expand behind transparent nav bar
        bottomNavigationBar: FadeInUp(
          duration: const Duration(milliseconds: 600),
          child: CustomAnimatedNavBar(
            currentIndex: currentScreen,
            onTap: (index) async {
              if (index > 0) {
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
              }
              setState(() {
                currentScreen = index;
              });
              pageController.jumpToPage(currentScreen);
            },
            items: [
              CustomNavItem(icon: Icons.home_rounded, label: 'Home'),
              CustomNavItem(icon: Icons.shopping_cart_rounded, label: 'Cart'),
              CustomNavItem(icon: Icons.history_rounded, label: 'History'),
              CustomNavItem(icon: Icons.person_rounded, label: 'Profile'),
            ],
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: screens,
        ),
      ),
    );
  }
}
