import 'package:dio/dio.dart';
import 'url_config.dart';

class HttpConfig {
  static const connectTimeout = 5000;

  static const receiveTimeout = 5000;

  // 自定义Header
  static const Map<String, dynamic> httpHeaders = {
    'Accept': 'application/json,*/*',
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Credentials": true,
    "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS, HEAD",
  };

  //业务code成功
  static const codeResponseSuccess = 1;

  //其他未知错误
  static const codeErrorUnknown = -1;

  //基础配置
  static final options = BaseOptions(baseUrl: UrlConfig.SERVER_HOST, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, headers: httpHeaders);

  /*
   * 签名密码
   */
  static const String SIGN_PASSWORD = "U2FsdGVkX1+3ZAY5f3aL69==";

  /*
   * 数据条数
   */
  static const int LIMIT = 10;
}
