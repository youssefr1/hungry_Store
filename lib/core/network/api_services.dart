import 'package:dio/dio.dart';
import 'package:hungry_store/core/network/api_exceptions.dart';
import 'package:hungry_store/core/network/dio_client.dart';

class ApiServices{

  final DioClient _dioClient = DioClient();


  // CRUD Methods

// Get
Future<dynamic> get (String endpoints)async{
    try {
      final response = await _dioClient.dio.get(endpoints);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    }


}



// Put // Update
Future<dynamic> put (String endpoints,dynamic body)async {
    try {
      final response = await _dioClient.dio.put(endpoints,data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    }

}



//  post
Future<dynamic> post (String endpoints,dynamic body)async {
    try {
      final response = await _dioClient.dio.post(
          endpoints, data: body);
      return response.data;
    }on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    }
}



// Delete
Future<dynamic> delete (String endpoints)async {
    try {
      final response = await _dioClient.dio.delete(endpoints);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    }
}

}