import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/keep_alive_view.dart';
import '../home/home_page.dart';
import '../mine/mine_page.dart';
import '../tool/tool_page.dart';

class MainController extends GetxController {
  int currentIndex = 2;
  var pageController = PageController(initialPage: 2);
  late List<Widget> pageViews;
  final Map<String, String> bottomNames = {
    'home': "首页",
    'tool': "工具",
    'mine': "我的",
  };

  @override
  void onInit() {
    super.onInit();
    pageViews = [
      KeepAliveView(HomePage()),
      KeepAliveView(ToolPage()),
      KeepAliveView(MinePage()),
    ];
  }

  void onPushPage(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    currentIndex = index;
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
