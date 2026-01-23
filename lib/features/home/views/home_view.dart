import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/core/constants/app_colors.dart';
import 'package:hungry_store/features/home/widgets/category_Llsit.dart';
import 'package:hungry_store/features/home/widgets/user_header.dart';
import 'package:hungry_store/features/home/widgets/cart_item.dart';
import 'package:hungry_store/features/product/views/product_details_view.dart';
import 'package:hungry_store/shared/custom_text.dart';

import '../widgets/serach_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> category = [
    'All',
    'Combo',
    'Sliders',
    'Classic',
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(elevation: 0,
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              toolbarHeight: 195,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
                child: Column(
                  children: [
                    UserHeader(),
                    // Search bar
                    Gap(20),
                    SerachBar(),


                  ],
                ),
              ),
            ),
            //Search + Category
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child: FoodCategory(selectedIndex: selectedIndex, category: category)

                    // Product GridView Items
                  
                ),
              ),

            // GridView
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: 6,
                  (context, index) {
                    return GestureDetector( 
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c){
                          return ProductDetailsView();
                        }));
                      },
                      child: CartItem(
                        image: 'assets/logo/image 6.png',
                        text: 'Chess Burger',
                        desc: 'Wendy\'s Burger',
                        rate: '4.9',
                      ),
                    );
                  },
                ),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
