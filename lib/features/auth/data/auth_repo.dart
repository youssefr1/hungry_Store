import 'package:dio/dio.dart';
import 'package:hungry_store/core/network/api_error.dart';
import 'package:hungry_store/core/network/api_services.dart';
import 'package:hungry_store/features/auth/data/user_model.dart';

import '../../../core/network/api_exceptions.dart';
import '../../../core/utils/pref_helper.dart';

class AuthRepo {
  ApiServices apiServices = ApiServices();

  // login

  Future<UserModel?> login(String email, String password,) async {
    try {
      final response = await apiServices.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        if(code != 200 ||data ==null){
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      }else{
        throw ApiError(message: 'UnExpected Error From Server');
      }


    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }


  // signup
  Future<UserModel?> signUp(String name, String email, String password,) async {
    try {
      final response = await apiServices.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        if(code != 200 ||data ==null){
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      }else{
        throw ApiError(message: 'UnExpected Error From Server');
      }


    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

// logout

//get profile

// update profile
