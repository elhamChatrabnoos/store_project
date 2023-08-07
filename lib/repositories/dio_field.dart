import 'package:dio/dio.dart';

final Dio dioBaseUrl = Dio(

  BaseOptions(
    // baseUrl: 'http://localhost:3000/',
    baseUrl: 'http://192.168.191.62:3000/',
    receiveDataWhenStatusError: true,
    // connectTimeout: const Duration(seconds: 3),
  ),

);