import 'package:logger/logger.dart';

class LogUtil {
  ///是否调试模式
  // static const bool IS_DEBUG = !bool.fromEnvironment("dart.vm.product");
  static const bool IS_DEBUG = true;
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
    ),
  );

  static void v(String tag, String msg) {
    if (IS_DEBUG) {
      _logger.v("=====$tag===== :: $msg");
    }
  }

  static void i(String tag, String msg) {
    if (IS_DEBUG) {
      _logger.i("=====$tag===== :: $msg");
    }
  }

  static void d(String tag, String msg) {
    if (IS_DEBUG) {
      _logger.d("=====$tag===== :: $msg");
    }
  }

  static void w(String tag, String msg) {
    if (IS_DEBUG) {
      _logger.w("=====$tag===== :: $msg");
    }
  }

  static void e(String tag, String msg) {
    if (IS_DEBUG) {
      _logger.e("=====$tag===== :: $msg");
    }
  }
}
