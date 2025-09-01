import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loginpage/product_model.dart';
import 'package:loginpage/user_data_model/personal_data.dart';
import 'package:loginpage/user_singleton.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiResponse<T> {
  final String? errorMessage;
  final T? data;
  ApiResponse({required this.errorMessage, required this.data});
}

class Apiservice {
  static final Dio _dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printErrorData: true,
          printErrorHeaders: true,
          printRequestData: true,
          printErrorMessage: true,
        ),
      ),
    );

  static Future<Map<String, dynamic>> userLogin(
    String userName,
    String password,
  ) async {
    Response? response;
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Mobile-Request': 'Secure',
      };
      response = await _dio.post(
        'https://hr.esoftmm.com/core/api/auth/access-token',
        data: {'username': userName, 'password': password, 'device': 'android'},
        options: Options(headers: headers),
      );

      return {'success': true, 'data': response.data['data']};
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return {'message': 'no internet connection'};
      } else if (e.response!.data != null) {
        return e.response!.data;
      } else {
        return {'message': 'something went wrong'};
      }
    }
  }

  static Future<Map<String, dynamic>> refreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Mobile-Request': 'Secure',
      };

      final response = await _dio.post(
        'https://hr.esoftmm.com/core/api/auth/refresh-token',
        data: {
          'access_token': accessToken,
          'refresh_token': refreshToken,
          'device': 'android',
        },
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return {'success': false, 'message': 'Something went wrong'};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return {'success': false, 'message': 'Unauthorized'};
      } else if (e.response?.data != null) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'Token refresh failed',
          'error': e.response?.data,
        };
      } else if (e.error is SocketException) {
        return {'success': false, 'message': 'No internet connection'};
      } else {
        return {'success': false, 'message': 'Something went wrong'};
      }
    }
  }

  static Future<ApiResponse<List<Product>>> getProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        final list = response.data as List;
        final productList = list.map((data) => Product.fromJson(data)).toList();
        return ApiResponse(errorMessage: null, data: productList);
      } else {
        return ApiResponse(errorMessage: 'something went wrong', data: null);
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return ApiResponse(errorMessage: 'no internet connection', data: null);
      } else {
        return ApiResponse(errorMessage: 'something went wrong', data: null);
      }
    } catch (e) {
      return ApiResponse(errorMessage: e.toString(), data: null);
    }
  }

  static Future<ApiResponse<PersonalData>> personalData(
    String accessToken,
  ) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Mobile-Request': 'Secure',
        'Authorization':
            "Bearer ${CurrentUserSingleton().currentuser!.accessToken}",
      };

      final response = await _dio.get(
        'https://hr.esoftmm.com/core/api/m/personal',
        data: {'access_token': accessToken, 'device': 'android'},
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final personaldata = PersonalData.fromJson(response.data['data']);
        return ApiResponse(errorMessage: null, data: personaldata);
      } else {
        return ApiResponse(errorMessage: 'something went wrong', data: null);
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return ApiResponse(errorMessage: 'no internet connection', data: null);
      } else {
        return ApiResponse(errorMessage: 'something went wrong', data: null);
      }
    } catch (e) {
      return ApiResponse(errorMessage: 'something went wrong', data: null);
    }
  }
}
