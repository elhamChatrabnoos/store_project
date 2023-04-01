import 'package:dio/dio.dart';

final Dio dioBaseUrl = Dio(

  BaseOptions(
    baseUrl: 'http://localhost:3000/',
    // baseUrl: 'http://192.168.178.61:4242/',
    // baseUrl: 'http://10.0.2.2:8080/',
    // baseUrl: 'http://10.0.0.2:3000/',
    // baseUrl: 'http://127.0.0.1:3000/',
    // baseUrl: 'http://192.168.137.176:3000/',
    // baseUrl: 'http://10.0.2.2:4242/',
    // baseUrl: 'http://10.0.2.3:3000/',
    // baseUrl: 'http://192.168.178.61:3000/',
    // baseUrl: 'http://192.168.137.1:3000/',
    // baseUrl: 'http://192.168.56.1:8000/',
    // baseUrl: 'http://192.168.142.2:3000/',
    // baseUrl: 'http://192.168.63.61/',
    receiveDataWhenStatusError: true,
    // connectTimeout: const Duration(seconds: 3),
  ),

);