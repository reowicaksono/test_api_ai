import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  Dio init() {
    Dio dio = new Dio();
    dio.options.connectTimeout = 60 * 1000;
    dio.options.receiveTimeout = 60 * 1000;
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(new ApiInterceptors());
    return dio;
  }
}

class ApiInterceptors extends Interceptor {}
