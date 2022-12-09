import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../app/model/app_version_bean.dart';
import '../../app/modules/mine/app_upgrade_page.dart';
import '../../app/routes/navigation_utils.dart';
import '../dio_http/response_data.dart';
import 'object_util.dart';
import 'toast_util.dart';

class CommonUtils {
  static String getImageByName(String imageName) {
    return 'assets/images/$imageName.webp';
  }

  static String getIconByName(String iconName) {
    return 'assets/icons/$iconName.webp';
  }

  //转为rpx
  static double toRpx(BuildContext context, double size) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return size * rpx;
  }

  static formatCharCount(int? count) {
    if (count == null || count <= 0 || count.isNaN) return "0";
    String countStr = count.toString();
    if (countStr.length >= 5) {
      String prefix = countStr.substring(0, countStr.length - 4);
      if (countStr.length == 5) {
        prefix += '.${countStr[1]}';
      }
      if (countStr.length == 6) {
        prefix += '.${countStr[2]}';
      }

      return "${prefix}w";
    }
    return countStr;
  }

  static int getRandomRangeInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max + 1 - min);
  }

  //将String转为集合
  static List<String> string2List(String data, String regex, String server) {
    List<String> dataList = [];
    if (!ObjectUtil.isEmptyString(data)) {
      List<String> split = data.split(regex);
      for (int i = 0; i < split.length; i++) {
        if (!ObjectUtil.isEmptyString(split[i])) {
          dataList.add(server + split[i]);
        }
      }
    }
    return dataList;
  }

  //将集合转为String
  static String list2String(List<String> dataList, String regex) {
    if (ObjectUtil.isEmptyList(dataList)) {
      return "";
    }
    String builder = "";

    for (int i = 0; i < dataList.length; i++) {
      if (i != 0) {
        builder += regex;
      }
      builder += dataList[i];
    }
    return builder.toString();
  }

  static String getURLDecoderString(String str) {
    return Uri.decodeComponent(str);
  }

  static bool isChinaPhoneLegal(String phone) {
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(phone);
    return matched;
  }

  static String dealPhoneNumber(String phoneNumber) {
    if (!ObjectUtil.isEmptyString(phoneNumber)) {
      int len = phoneNumber.length;
      String builder = "";
      for (int i = 0; i < len; i++) {
        if (i > 2 && i < 7) {
          builder += "*";
        } else {
          builder += phoneNumber[i];
        }
      }
      return builder.toString();
    }
    return "";
  }

  static Future<bool> checkAppVersion(BuildContext context, {bool showToast = false}) async {
    //模拟网络请求
    Resource resource = await Future.delayed(const Duration(milliseconds: 1000), () {
      return Resource(data: {
        "isNeed": true,
        "updateContent": "优化了一些bug,程序员们正在努力中",
        "packageUrl": "https://gdown.baidu.com/appcenter/pkg/upload/3d73fd121c2fa35c67149301a49052d6"
      }, code: 1);
    });

    if (resource.code == 1) {
      AppVersionBean appVersionBean = AppVersionBean.fromJson(resource.data);
      if (appVersionBean.isNeed!) {
        showAppUpgradeDialog(context: context, contextText: appVersionBean.updateContent!, apkUrl: appVersionBean.packageUrl!);
      } else {
        if (showToast) {
          ToastUtil.toast(context, "已是最新版本");
        }
      }
    }
    return true;
  }

  static void showAppUpgradeDialog({
    required BuildContext context,
    bool isBackDismiss = false,
    bool isForce = false,
    String contextText = "",
    String apkUrl = "",
  }) {
    NavigatorUtils.pushPageByFade(context: context, targetPage: AppUpgradePage(contextText: contextText, apkUrl: apkUrl), isOpaque: false);
  }

  static Future<String> getPhoneLocalPath(BuildContext context) async {
    Directory? directory =
        Theme.of(context).platform == TargetPlatform.android ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    return directory!.path;
  }
}
