import 'package:dio/dio.dart';
import 'config/http_config.dart';
import 'config/url_config.dart';
import 'interceptor/params_Interceptors.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();

  factory DioManager() => _instance;

  late Dio dio;

  DioManager._internal() {
    _initDio();
  }

  // 完成DIO的基础配置
  void _initDio() {
    dio = Dio(HttpConfig.options);
    dio.interceptors.add(ParamsInterceptor());
    dio.interceptors.add(LogInterceptor());
  }

  static DioManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  DioManager _baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    return this;
  }

  //一般请求，默认域名
  DioManager _normal() {
    if (dio.options.baseUrl != UrlConfig.SERVER_HOST) {
      dio.options.baseUrl = UrlConfig.SERVER_HOST;
    }
    return this;
  }
}
