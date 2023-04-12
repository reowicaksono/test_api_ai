import 'package:ai_example/utils/app_constants.dart';
import 'package:ai_example/utils/app_preferences.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  Dio init() {
    Dio dio = new Dio();
    dio.options.connectTimeout = 60 * 1000;
    dio.options.receiveTimeout = 60 * 1000;
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(new ApiInterceptors());
    dio.options.baseUrl = "$BASE_URL_API/";
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  final AppPreferences preferences = new AppPreferences();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await preferences.getToken();

    if (token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer" + token;
      super.onRequest(options, handler);
    }
  }

  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
