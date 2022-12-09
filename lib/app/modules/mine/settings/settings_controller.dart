import 'dart:math';

import 'package:get/get.dart';
import '../../../../common/extensions/event_fn.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../common/utils/dialog_util.dart';
import '../../../../common/utils/event_bus_util.dart';
import '../../../../common/utils/login_util.dart';
import '../../../../common/utils/toast_util.dart';
import '../../../constant/event_bus_id_constant.dart';
import '../../../routes/app_routes.dart';

class SettingsController extends GetxController {
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

  void onLogin() {
    if (isLogin) {
      exitLogin();
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  void exitLogin() {
    DialogUtil.showCupertinoAlertDialog(
        title: "温馨提示",
        msg: "确定退出登录吗?",
        onConfirm: () {
          LoginUtil.clearUserInfo();
          ToastUtil.toast(Get.context!, "已退出登录!");
          EventBusUtil.getInstance().fire(EventFn(out_success));
          Get.back();
        });
  }

  void onCheck() async {
    await CommonUtils.checkAppVersion(Get.context!);
  }
}
