import 'package:get/get.dart';

import '../../../common/utils/login_util.dart';

class MineController extends GetxController {
  bool isLogin = false;

  @override
  void onInit() async {
    super.onInit();
    isLogin = await LoginUtil.getInstance().isLogin();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
