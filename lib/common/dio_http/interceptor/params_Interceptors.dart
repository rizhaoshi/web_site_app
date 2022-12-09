import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import '../../utils/log_util.dart';
import '../common_parameter.dart';
import '../config/http_config.dart';

class ParamsInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> new_params = {};
    String afferentStr = "";
    new_params['common'] = getCommonParams()["common"];
    final data = options.data;
    if (data != null) {
      if (data is Map) {
        data.forEach((key, value) {
          new_params[key] = value;
        });
        options.data = new_params;
        afferentStr += json.encode(new_params);
      } else if (data is FormData) {
        final formDataMap = {}
          ..addEntries(data.fields)
          ..addEntries(data.files);
        afferentStr += json.encode(formDataMap);
      } else {
        afferentStr += json.encode(data);
      }

      LogUtil.i("requestStr", afferentStr);
      String sign = getSignEncryption(afferentStr);
      options.path += "?sign=$sign";

      return handler.next(options);
    }
  }

  Map<String, dynamic> getCommonParams() {
    Map<String, dynamic> commonParams = {};
    commonParams["common"] = CommonParameter.instance;
    return commonParams;
  }

  String getSignEncryption(String str) {
    var content = const Utf8Encoder().convert(str + HttpConfig.SIGN_PASSWORD);

    return md5.convert(content).toString();
  }

  // 你也可以在响应或错误时执行一些动作
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
