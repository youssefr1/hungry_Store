import 'package:dio/dio.dart';
import 'package:hungry_store/core/network/api_error.dart';
import 'package:hungry_store/core/network/dio_client.dart';

class ApiExceptions{
  static ApiError handleApiError(DioException error) {
    final statusCode = error.response?.statusCode;
     final data = error.response?.data;
if(data is Map<String,dynamic> && data.containsKey('message')){
  return ApiError(message: data['message'],statusCode: statusCode);
}

    switch(error.type){
      case DioExceptionType.connectionTimeout:
        return ApiError( message: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ApiError( message: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
       return ApiError( message: 'Receive Timeout');
      default:
        return ApiError( message: 'An unexpected error occurred please try again ');


    }
  }
}