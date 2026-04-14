import 'package:dio/dio.dart';
import 'package:hungry_store/core/network/api_error.dart';
import 'package:hungry_store/core/network/api_services.dart';
import 'package:hungry_store/features/cart/data/cart_model.dart';
import '../../../core/network/api_exceptions.dart';

import 'package:hungry_store/features/checkout/data/order_model.dart';

class OrderRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<OrderModel>> getOrderHistory() async {
    try {
      final response = await _apiServices.get('orders');
      if (response != null && response['data'] != null) {
        if (response['data'] is List) {
          return (response['data'] as List)
              .map((e) => OrderModel.fromJson(e))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> placeOrder(List<CartModel> cartItems) async {
    final body = {
      'items': cartItems.map((item) => {
        'product_id': item.productId,
        'quantity': item.quantity,
        'spicy': item.spicy,
        'toppings': item.toppings,
        'side_options': item.sideOptions,
      }).toList()
    };
    
    try {
      await _apiServices.post('orders', body);
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // Future<List<OrderModel>> getOrderHistory() async { ... }
}
