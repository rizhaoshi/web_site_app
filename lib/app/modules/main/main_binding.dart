import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../login/login_controller.dart';
import '../mine/mine_controller.dart';
import '../mine/settings/settings_controller.dart';
import '../tool/tool_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
    Get.lazyPut<SettingsController>(
          () => SettingsController(),
    );
    Get.lazyPut<ToolController>(
          () => ToolController(),
    );
  }
}
