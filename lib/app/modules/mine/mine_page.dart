import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/extensions/event_fn.dart';
import '../../../common/utils/event_bus_util.dart';
import '../../../common/utils/log_util.dart';
import '../../constant/event_bus_id_constant.dart';
import 'mine_controller.dart';
import 'mine_login_page.dart';
import 'mine_no_login_page.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MineController controller = Get.find<MineController>();
  var eventBusFn;

  @override
  void initState() {
    super.initState();
    _registerEventBus();
  }

  _registerEventBus() {
    eventBusFn = EventBusUtil.getInstance().on<EventFn>().listen((event) {
      switch (event.event) {
        case login_success:
          LogUtil.i('registerEventBus', event.event);
          setState(() {
            controller.isLogin = true;
          });

          break;
        case out_success:
          setState(() {
            controller.isLogin = false;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MineController>(
        builder: (ctx) {
          return controller.isLogin ? MineLoginPage() : MineNoLoginPage();
        },
      ),
    );
  }
}
