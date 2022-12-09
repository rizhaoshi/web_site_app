import 'package:get/get.dart';

import 'tool_controller.dart';

class ToolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToolController>(
      () => ToolController(),
    );
  }
}
