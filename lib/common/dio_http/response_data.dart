import 'config/http_config.dart';

class Resource {
  int code;
  String? message;
  dynamic data;

  Resource({required this.data, required this.code, this.message});

  ///
  /// 业务请求成功，服务端返回业务code值为codeResponseSuccess
  ///
  Resource.success(this.data, {this.code = HttpConfig.codeResponseSuccess});

  ///
  /// 业务code不为success或者其他错误
  ///
  Resource.error(this.message, this.code);

  ///
  ///
  /// 业务流程是否正常
  ///
  bool isSuccess() {
    return code == HttpConfig.codeResponseSuccess;
  }
}


class ErrorResponse {
  String code;
  String error;

  ErrorResponse(this.code, this.error);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['error'] = error;
    return data;
  }
}
