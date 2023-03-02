import 'package:dio/dio.dart';

final Dio dioBaseUrl = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:3000/',
    // baseUrl: 'http://10.0.2.2:3000/',
    receiveDataWhenStatusError: true,
    // connectTimeout: const Duration(seconds: 3),
  ),
);