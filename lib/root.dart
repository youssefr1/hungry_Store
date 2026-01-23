import 'package:flutter/material.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry_store/core/constants/app_colors.dart';

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
  late PageController pageController ;
   late List<Widget> screens;
   int currentScreen = 0 ;
   @override
  void initState() {
    screens = [
      HomeView(),
      CartView(),
      OrderHistoryView(),
      ProfileView(),
    ];
    pageController = PageController(initialPage: currentScreen);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(18.r)
        ),
        padding: EdgeInsets.all(10),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.local_dining_sharp),label: 'Order History'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
            ] ,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade500.withOpacity(0.7),
          currentIndex: currentScreen,
          onTap:(index){
            setState(() {
              currentScreen = index ;
            });
            pageController.jumpToPage(currentScreen);
          } ,
        ),
      ),
      body: PageView(
        physics:NeverScrollableScrollPhysics() ,
        controller: pageController,
        children: screens,
      ),
    );
  }
}
