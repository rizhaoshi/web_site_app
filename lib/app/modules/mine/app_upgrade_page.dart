import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:install_plugin_custom/install_plugin_custom.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../common/config/app_colors.dart';
import '../../../common/utils/common_util.dart';
import '../../../common/utils/log_util.dart';

class AppUpgradePage extends StatefulWidget {
  bool isForce;
  bool isBackDismiss;
  String contextText;
  String apkUrl;

  AppUpgradePage({
    Key? key,
    this.isForce = false,
    this.isBackDismiss = false,
    this.contextText = "",
    required this.apkUrl,
  }) : super(key: key);

  @override
  State<AppUpgradePage> createState() => _AppUpgradePageState();
}

class _AppUpgradePageState extends State<AppUpgradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Material(
        type: MaterialType.transparency,
        child: WillPopScope(
            child: GestureDetector(
              onTap: () {
                if (!widget.isForce && widget.isBackDismiss) {
                  closeApp(context);
                }
              },
              child: _buildBodyContainer(),
            ),
            onWillPop: () async {
              closeApp(context);
              return Future.value(true);
            }),
      ),
    );
  }

  Widget _buildBodyContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        width: 280,
        height: 320,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 14),
                child: Text(widget.contextText, style: const TextStyle(fontSize: 16,color: AppColors.color_f20)),
              ),
            )),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const Positioned(
              left: 0,
              right: 0,
              top: 28,
              child: Text(
                "升级版本",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue),
              )),
          Positioned(
              right: 0,
              child: CloseButton(
                onPressed: () {
                  closeApp(context);
                },
              )),
        ],
      ),
    );
  }

  final StreamController<double> _streamController = StreamController();

  Widget _buildBottom() {
    return StreamBuilder<double>(
        stream: _streamController.stream,
        initialData: 0.0,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          return Container(
            child: Stack(
              children: [
                Material(
                  color: Colors.redAccent,
                  child: Ink(
                    child: InkWell(
                      onTap: onTapFunction,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Text(
                          buildBottomText(snapshot.data),
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: snapshot.data,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  String buildBottomText(double? progress) {
    String buttonText = "";
    switch (_installStatues) {
      case InstallStatues.none:
        buttonText = '升级';
        break;
      case InstallStatues.downing:
        buttonText = '下载中${(progress! * 100).toStringAsFixed(0)}%';
        break;
      case InstallStatues.downFinish:
        buttonText = '点击安装';
        break;
      case InstallStatues.downFaile:
        buttonText = '重新下载';
        break;
      case InstallStatues.installFaile:
        buttonText = '重新安装';
        break;
    }
    return buttonText;
  }

  void closeApp(BuildContext context) {
    if (widget.isForce) {
      SystemChannels.platform.invokeMethod("SystemNavigator.pop");
    } else {
      Navigator.of(context).pop();
    }
  }

  void onTapFunction() {
    //如果是iOS手机就跳转APPStore
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      InstallPluginCustom.gotoAppStore("https://apps.apple.com/cn/app/id1453826566");
      return;
    }
    //第一次下载
    //下载失败点击重试
    if (_installStatues == InstallStatues.none || _installStatues == InstallStatues.downFaile) {
      _installStatues = InstallStatues.downing;
      downApk();
    } else if (_installStatues == InstallStatues.downFinish || _installStatues == InstallStatues.installFaile) {
      //安装失败时
      //下载完成时 点击触发安装
      installApk();
    }
  }

  String appLocalPath = "";
  late CancelToken _cancelToken;

  //当前状态
  late InstallStatues _installStatues = InstallStatues.none;

  void downApk() async {
    String savePath = await CommonUtils.getPhoneLocalPath(context);
    String appName = "basics_flutter.apk";
    Dio dio = Dio();
    _cancelToken = CancelToken();
    appLocalPath = "$savePath$appName";
    try {
      Response response = await dio.download(widget.apkUrl, appLocalPath, cancelToken: _cancelToken, onReceiveProgress: (received, total) {
        if (total != -1) {
          ///当前下载的百分比例
          LogUtil.i("downApk", "${(received / total * 100).toStringAsFixed(0)}%");
          // CircularProgressIndicator(value: currentProgress,) 进度 0-1
          _streamController.add(received / total);
          setState(() {});
        }
      });
      setState(() {
        _streamController.add(0.0);
      });
      _installStatues = InstallStatues.downFinish;
      installApk();
    } catch (e) {
      LogUtil.i("downApk", e.toString());
      //取消网络请求
      //下载失败都会在这回调
      //可自行处理
      _installStatues = InstallStatues.downFaile;
      setState(() {});
    }
  }

  void installApk() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    //开始安装
    InstallPluginCustom.installApk(appLocalPath, packageName).then((result) {
      LogUtil.i("installApk", 'install apk $result');
    }).catchError((error) {
      //安装失败
      _installStatues = InstallStatues.installFaile;
      setState(() {});
    });
  }
}

enum InstallStatues {
  //无状态
  none,
  //下载中
  downing,
  //下载完成
  downFinish,
  //下载失败
  downFaile,
  //安装失败
  installFaile,
}
