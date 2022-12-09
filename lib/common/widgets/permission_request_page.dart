import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/object_util.dart';

//权限请求页面
class PermissionRequestPage extends StatefulWidget {
  final Permission permission;
  final List<String> list;
  final bool isCloseApp;
  final String leftStr;

  const PermissionRequestPage({Key? key, required this.permission, required this.list, this.isCloseApp = false, this.leftStr = "取消"}) : super(key: key);

  @override
  State<PermissionRequestPage> createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _checkPermission();
    //页面跳转 注册观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed && isGoSetting) {
      _checkPermission();
      isGoSetting = false;
    }
  }

  @override
  void dispose() {
    //注销观察者
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }

  void _checkPermission({PermissionStatus? status}) async {
    Permission permission = widget.permission;

    if (ObjectUtil.isEmpty(status)) {
      status = await permission.status;
    }
    if (status!.isGranted) {
      Navigator.of(context).pop(true);
    } else if (status.isDenied) {
      showPermissionAlert(widget.list[0], rightStr: "同意", onConfirm: () {
        requestPermission(permission);
      });
    } else if (status.isPermanentlyDenied || status.isRestricted) {
      showPermissionAlert(widget.list[1], rightStr: "去设置中心", onConfirm: () {
        openAppSettings();
        isGoSetting = true;
      });
    } else {
      showPermissionAlert(widget.list[0], rightStr: "同意", onConfirm: () {
        requestPermission(permission);
      });
    }
  }

  //是否去设置中心
  bool isGoSetting = false;

  void showPermissionAlert(String message, {String rightStr = "同意", Function? onConfirm}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext cxt) {
          return CupertinoAlertDialog(
            title: const Text("温馨提示"),
            content: Container(padding: const EdgeInsets.all(12), child: Text(message)),
            actions: [
              CupertinoDialogAction(
                child: Text(widget.leftStr),
                onPressed: () {
                  if (widget.isCloseApp) {
                    _closeApp();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text(rightStr),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
              ),
            ],
          );
        });
  }

  void requestPermission(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    _checkPermission(status: status);
  }

  void _closeApp() {
    //退出应用
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }
}
