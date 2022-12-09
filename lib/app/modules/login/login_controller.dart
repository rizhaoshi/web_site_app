import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/extensions/event_fn.dart';
import '../../../common/storage/storage_constant.dart';
import '../../../common/storage/storage_util.dart';
import '../../../common/utils/event_bus_util.dart';
import '../../../common/utils/login_util.dart';
import '../../../common/utils/toast_util.dart';
import '../../constant/event_bus_id_constant.dart';
import '../../model/login_model.dart';
import '../../model/user_bean.dart';

class LoginController extends GetxController {
  final FocusNode userPhoneFocusNode = FocusNode();
  final FocusNode userPasswordFocusNode = FocusNode();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  bool passwordShow = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onPasswordShow() {
    passwordShow = !passwordShow;
    update();
  }

  void onToLogin(BuildContext context) {
    String userPhone = userPhoneController.text.toString().trim();
    String userPassword = userPasswordController.text.toString().trim();

    if ("17521272305" == userPhone && "77018250" == userPassword) {
      // StorageUtil.instance.putBool(StorageConstant.IS_LOGIN, true);
      LoginModel data = LoginModel();
      data.user = UserBean(mobile: userPhone, token: userPassword);
      LoginUtil.setLoginInfo(data);
      ToastUtil.toast(context, "登录成功!");
      EventBusUtil.getInstance().fire(EventFn(login_success));
      Get.back();
    } else {
      ToastUtil.toast(context, "手机号或密码错误!");
    }
  }
}
