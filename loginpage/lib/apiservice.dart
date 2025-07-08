// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:talker_dio_logger/talker_dio_logger.dart';

// class Apiservice {
//   static final Dio _dio = Dio();
//     // ..interceptors.add(
//     //   TalkerDioLogger(
//     //     settings: TalkerDioLoggerSettings(
//     //       printErrorData: true,
//     //       printErrorHeaders: true,
//     //       printRequestData: true,
//     //       printErrorMessage: true,
//     //     ),
//     //   ),
//     // );

//   static Future<Map<String, dynamic>> userLogin(String email, String password)async{
//     try {
//       var response = await _dio.post('https://hr.esoftmm.com/core/api/auth/access-token',data:{ 'username': email,'password': password} );
//       return {
//         'sucess': true,
//         'data' : response.data,
//       };
//       catch(e){
// return {
//   'sucess': false,
//   'message': 'Something went wrong',
//   'error' : e.toString(),
// };
//       }
//     }} }

// static Future<bool> userLogin(String email, String password) async {
//   var headers = {
//     'Content-Type': 'application/json',
//     'Mobile-Request': 'Secure',
//   };
//   final data = {"username": email, "password": password, 'device': 'android'};
//   try {
//     final response = await _dio.post(
//       'https://hr.esoftmm.com/core/api/auth/access-token',
//       data: jsonEncode(data),

//       options: Options(headers: headers),
//     );

//     print('Login Success: ${response.data}');
//     response.statusCode;
//     return true;
//   } catch (e) {
//     if (e is DioException) {
//       final statuscode = e.response?.statusCode;
//       if (statuscode == 200 || statuscode == 201) {
//         //sucesss
//       }else
//       {
//         print(e.message);
//         //fail
//       }
//     }
//     print('Login Error: $e');
//     return false;
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

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

  static Future<Map<String, dynamic>?> userLogin(
    String email,
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
        data: {'username': email, 'password': password, 'device': 'android'},
        options: Options(headers: headers),
      );
      return {'success': true, 'data': response.data};
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
}








// static Future<Map<String, dynamic>> userLogin(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Mobile-Request': 'Secure',
  //     };
  //     var response = await _dio.post(
  //       'https://hr.esoftmm.com/core/api/auth/access-token',
  //       data: {'username': email, 'password': password, 'device': 'android'},
  //       options: Options(headers: headers),
  //     );
  //     return {'success': true, 'data': response.data};
  //   } catch (e) {
  //     debugPrint('ErrorLog ${e.toString()}');
  //     return {
  //       'success': false,
  //       'message': 'Something went wrong',
  //       'error': e.toString(),
  //     };
  //   }
  // }
