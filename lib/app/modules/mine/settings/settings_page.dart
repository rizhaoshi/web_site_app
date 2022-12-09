import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
      ),
      body: GetBuilder<SettingsController>(
        builder: (cxt) {
          return ListView(
            children: [
              _buildLoginView(),
              _buildCheckVersionView(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginView() {
    return ListTile(
      title: Text(controller.isLogin ? "退出登录" : "去登录"),
      trailing: const Icon(Icons.arrow_forward_ios),
      leading: const Icon(Icons.output),
      onTap: () {
        controller.onLogin();
      },
    );
  }

  Widget _buildCheckVersionView() {
    if (Platform.isAndroid) {
      return ListTile(
        title:const Text("检查更新"),
        trailing: const Icon(Icons.arrow_forward_ios),
        leading: const Icon(Icons.vertical_align_bottom),
        onTap: () {
          controller.onCheck();
        },
      );
    } else {
      return Container();
    }
  }
}
