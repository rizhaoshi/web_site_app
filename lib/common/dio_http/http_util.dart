import 'package:dio/dio.dart';
import '../utils/log_util.dart';
import 'config/http_config.dart';
import 'dio_manager.dart';
import 'response_data.dart';

enum HttpMethodType {
  GET,
  POST,
}

class HttpUtil {
  ///
  /// get 请求
  ///
  ///
  static Future<Resource> get(
    String path, {
    String? url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _sendRequest(HttpMethodType.GET, url, path, queryParameters, options, cancelToken, onReceiveProgress);
  }

  ///
  /// post 请求
  ///
  ///
  static Future<Resource> post(
    String path, {
    String? url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _sendRequest(HttpMethodType.POST, url, path, queryParameters, options, cancelToken, onReceiveProgress);
  }

  ///
  ///统一发送请求预计返回值统一处理
  ///
  static Future<Resource> _sendRequest(
    HttpMethodType method,
    String? url,
    String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ) async {
    var dio = DioManager.getInstance(baseUrl: url).dio;
    try {
      Response? rsp;
      if (method == HttpMethodType.GET) {
        rsp = await dio.get(path, queryParameters: queryParameters);
      } else if (method == HttpMethodType.POST) {
        rsp = await dio.post(path, data: queryParameters);
      }
      if (rsp == null) return Resource.error('未知错误', HttpConfig.codeErrorUnknown);
      LogUtil.i("_sendRequest resource", "$rsp");
      return _handleResponse(rsp);
    } catch (err) {
      LogUtil.e("_sendRequest err", "$err");
      return Resource.error(_handleException(err), HttpConfig.codeErrorUnknown);
    }
  }

  static Resource _handleResponse(Response response) {
    if (_isSuccess(response.statusCode)) {
      int code = response.data['code'];
      String msg = response.data['message'];
      if (code == HttpConfig.codeResponseSuccess) {
        //这里尽量将业务中的code丢出去，方便开发中需要根据该code来进行一些特殊的处理
        return Resource.success(response.data['data'], code: code);
      } else {
        return Resource.error(msg, code);
      }
    } else {
      return Resource.error('未知错误', HttpConfig.codeErrorUnknown);
    }
  }

  ///状态码是否成功
  static bool _isSuccess(int? statusCode) {
    return (statusCode != null && statusCode >= 200 && statusCode < 300);
  }

  ///
  /// 统一处理异常-返回错误信息
  ///
  static String _handleException(ex) {
    if (ex is DioError) {
      switch (ex.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          return '网络超时';
        case DioErrorType.other:
          return '未知错误';
        case DioErrorType.response:
          int? statusCode = ex.response?.statusCode;
          switch (statusCode) {
            case 400:
              return '请求语法错误';
            case 401:
              return '没有权限';
            case 403:
              return '服务器拒绝执行';
            case 404:
              return '请求资源部存在';
            case 405:
              return '请求方法被禁止';
            case 500:
              return '服务器内部错误';
            case 502:
              return '无效请求';
            case 503:
              return '服务器异常';
            default:
              return '未知错误';
          }
        default:
          return '未知错误';
      }
    } else {
      return '未知错误';
    }
  }
}
