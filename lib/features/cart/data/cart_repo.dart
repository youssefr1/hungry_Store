import 'package:dio/dio.dart';
import 'package:hungry_store/core/network/api_error.dart';
import 'package:hungry_store/core/network/api_services.dart';
import 'package:hungry_store/features/cart/data/cart_model.dart';
import '../../../core/network/api_exceptions.dart';

class CartRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<CartModel>> getCart() async {
    try {
      final response = await _apiServices.get('cart');

      if (response == null) return [];

      // Response: { code, message, data: { id, total_price, items: [...] } }
      if (response is Map<String, dynamic>) {
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          final items = data['items'];
          if (items is List) {
            return items.map((e) => CartModel.fromJson(e)).toList();
          }
        }
      }

      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> addToCart({
    required int productId,
    required int quantity,
    required double spicy,
    List<int>? toppingIds,
    List<int>? sideIds,
  }) async {
    final body = {
      'items': [
        {
          'product_id': productId,
          'quantity': quantity,
          'spicy': spicy,
          'toppings': toppingIds ?? [],
          'side_options': sideIds ?? [],
        }
      ]
    };
    try {
      await _apiServices.post('cart/add', body);
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    try {
      await _apiServices.delete('cart/remove/$cartItemId');
    } on ApiError catch (e) {
      // If 404, the item is already gone (likely success for us)
      if (e.statusCode == 404) return;
      rethrow;
    } on DioException catch (e) {
      final apiError = ApiExceptions.handleApiError(e);
      if (apiError.statusCode == 404) return;
      throw apiError;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
