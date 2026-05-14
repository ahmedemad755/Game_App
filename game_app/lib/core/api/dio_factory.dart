import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

class DioFactory {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {'key': ApiConstants.apiKey}, // إضافة المفتاح لكل الطلبات تلقائياً
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );

    // إضافة Logger لرؤية الطلبات في الـ Console أثناء التطوير
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
    return dio;
  }
}