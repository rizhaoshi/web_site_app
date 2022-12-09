import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../common/utils/common_util.dart';
import 'main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTabClick(int index) {
      controller.onPushPage(index);
    }

    final List<BottomNavigationBarItem> _bottomNavBars = [];
    controller.bottomNames.forEach((key, value) {
      _bottomNavBars.add(_bottomNavBatItem(key, value));
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.pageViews,
        ),
        bottomNavigationBar: GetBuilder<MainController>(
          builder: (controller) {
            return BottomNavigationBar(
              onTap: _onTabClick,
              items: _bottomNavBars,
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
            );
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBatItem(String key, String value) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          CommonUtils.getIconByName("home_tab_$key" "_pass"),
          width: 20,
          height: 20,
        ),
        activeIcon: Image.asset(
          CommonUtils.getIconByName("home_tab_$key"),
          width: 20,
          height: 20,
        ),
        label: value,
        tooltip: "");
  }
}
