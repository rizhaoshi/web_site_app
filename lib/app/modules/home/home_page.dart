import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/utils/log_util.dart';
import '../../widgets/home_video_item_view.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: GetBuilder<HomeController>(builder: (cxt) {
        return NotificationListener(
            onNotification: (ScrollNotification notification) {
              Type runtimeType = notification.runtimeType;
              if (runtimeType == ScrollStartNotification) {
                LogUtil.i("NotificationListener", "滑动开始");
                controller.setScaffold(true);
              } else if (runtimeType == ScrollEndNotification) {
                LogUtil.i("NotificationListener", "滑动结束");
                controller.setScaffold(false);
              }
              return false;
            },
            child: ListView.builder(
                cacheExtent: 0,
                itemCount: 20,
                itemBuilder: (BuildContext cxt, int index) {
                  return HomeVideoItemView(
                    scaffold: controller.isScaffold,
                    streamController: controller.streamController,
                  );
                }));
      }),
    );
  }
}
