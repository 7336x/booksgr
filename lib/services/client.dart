import 'package:dio/dio.dart';

class Client {
  static final String _baseUrl = ' '; // our url
  static final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));
}
