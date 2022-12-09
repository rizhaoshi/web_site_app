import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../widgets/home_tool_item_view.dart';
import 'tool_controller.dart';

class ToolPage extends GetView<ToolController> {
  const ToolPage({Key? key}) : super(key: key);

  Future _onRefresh() async {
    await controller.onRefresh();
  }

  Future _onLoad() async {
    await controller.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text('ToolPage'),
        centerTitle: true,
      ),
      body: EasyRefresh(
        onRefresh: _onRefresh,
        header: ClassicalHeader(),
        onLoad: _onLoad,
        footer: ClassicalFooter(),
        controller: controller.refreshController,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        child: ListView.builder(
            itemCount: 60,
            itemBuilder: (BuildContext context, int index) {
              return HomeToolItemView();
            }),
      ),
    );
  }
}
