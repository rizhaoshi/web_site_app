import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../web/details_web_page.dart';

class SplashController extends GetxController {
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

  void onPushWebPage(String url, String title, List<Widget> actions) {
    Get.to(DetailsWebPage(webUrl: url, title: title, actions: actions));
  }
}
