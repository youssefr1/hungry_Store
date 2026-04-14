import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/home/widgets/category_Llsit.dart';
import 'package:hungry_store/features/home/widgets/user_header.dart';
import 'package:hungry_store/features/home/widgets/cart_item.dart';
import 'package:hungry_store/features/product/views/product_details_view.dart';
import 'package:hungry_store/features/auth/data/auth_repo.dart';
import 'package:hungry_store/features/auth/data/user_model.dart';
import 'package:hungry_store/features/home/data/product_model.dart';
import 'package:hungry_store/core/network/api_services.dart';
import 'package:hungry_store/features/product/data/product_extra_model.dart';
import 'package:hungry_store/shared/custom_loading.dart';
import '../widgets/serach_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiServices _apiServices = ApiServices();
  final AuthRepo _authRepo = AuthRepo();
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  UserModel? _user;
  int selectedIndex = 0;
  bool _isLoadingCategories = true;
  bool _isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    await Future.wait([
      _fetchCategories(),
      _fetchProfile(),
      _fetchProducts(),
    ]);
  }

  Future<void> _fetchProfile() async {
    try {
      final user = await _authRepo.getProfile();
      setState(() {
        _user = user;
      });
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await _apiServices.get('/categories');
      if (response != null && response['data'] != null) {
        setState(() {
          _categories = (response['data'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _fetchProducts({int? categoryId}) async {
    setState(() {
      _isLoadingProducts = true;
    });
    try {
      final endpoint = categoryId == null ? '/products' : '/products-by-category/$categoryId';
      final response = await _apiServices.get(endpoint);
      if (response != null && response['data'] != null) {
        setState(() {
          _products = (response['data'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      setState(() {
        _isLoadingProducts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
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
                    FadeInDown(
                        duration: Duration(milliseconds: 500),
                        child: UserHeader(userModel: _user)),
                    // Search bar
                    Gap(20),
                    FadeInDown(duration: Duration(milliseconds: 600), child: SerachBar()),


                  ],
                ),
              ),
            ),
            //Search + Category
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child: FadeInRight(
                    duration: Duration(milliseconds: 700),
                    child: _isLoadingCategories
                        ? const CustomLoading()
                        : FoodCategory(
                            selectedIndex: selectedIndex,
                            category: _categories,
                            onCategorySelected: (index) {
                              setState(() {
                                selectedIndex = index;
                              });
                              _fetchProducts(
                                categoryId: _categories[index].id,
                              );
                            },
                          )),

                    // Product GridView Items
                  
                ),
              ),

            _isLoadingProducts
                ? const SliverFillRemaining(
                    child: CustomLoading(),
                  )
                : SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: _products.length,
                        (context, index) {
                          final product = _products[index];
                          return FadeInUp(
                            duration: Duration(milliseconds: 800 + (index * 100)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) {
                                  return ProductDetailsView(product: product);
                                }));
                              },
                              child: CartItem(
                                image: product.image,
                                text: product.name,
                                desc: product.description,
                                rate: product.rating,
                              ),
                            ),
                          );
                        },
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
