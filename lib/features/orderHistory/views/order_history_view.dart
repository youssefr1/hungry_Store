import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry_store/features/orderHistory/widgets/order_history_card.dart';
import 'package:hungry_store/shared/custom_text.dart';

import 'package:hungry_store/features/checkout/data/order_repo.dart';
import 'package:hungry_store/features/checkout/data/order_model.dart';
import 'package:hungry_store/shared/custom_loading.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  final OrderRepo _orderRepo = OrderRepo();
  List<OrderModel> _orders = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final orders = await _orderRepo.getOrderHistory();
      if (mounted) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      appBar: AppBar(
        title: CustomText(text: 'Order History', weight: FontWeight.bold, size: 20.sp),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CustomLoading())
          : _error != null
              ? Center(child: CustomText(text: _error!, color: Colors.red))
              : _orders.isEmpty
                  ? Center(child: CustomText(text: 'No orders found', color: Colors.grey))
                  : CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return FadeInUp(
                                  duration: Duration(milliseconds: 300 + (index * 100)),
                                  child: OrderHistoryCard(order: _orders[index]),
                                );
                              },
                              childCount: _orders.length,
                            ),
                          ),
                        ),
                        SliverGap(120.h),
                      ],
                    ),
    );
  }
}
