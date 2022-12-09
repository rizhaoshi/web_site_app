import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import 'object_util.dart';

class DialogUtil {
  static void showCupertinoAlertDialog({
    title = "",
    String? msg,
    String? content,
    leftStr = "取消",
    rightStr = "确定",
    Function? onCancel,
    Function? onConfirm,
  }) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: ObjectUtil.isEmptyString(title) ? const SizedBox.shrink() : Text(title),
            content: Column(
              children: [
                const SizedBox(height: 10),
                ObjectUtil.isEmptyString(msg) ? const SizedBox.shrink() : Align(alignment: const Alignment(0, 0), child: Text(msg!)),
                ObjectUtil.isEmptyString(content)
                    ? const SizedBox.shrink()
                    : Align(alignment: const Alignment(0, 0), child: Text(content!, style: const TextStyle(fontSize: 14, color: AppColors.color_hint))),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(leftStr, style: const TextStyle(fontSize: 16, color: AppColors.color_hint)),
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
              ),
              CupertinoDialogAction(
                  child: Text(rightStr),
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm?.call();
                  }),
            ],
          );
        });
  }

  static void showCupertinoAlertDialog2(
    List<Widget> actions, {
    title = "",
  }) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: ObjectUtil.isEmptyString(title) ? const SizedBox.shrink() : Text(title),
            actions: actions,
          );
        });
  }

  static void showAlertDialog({
    title = "",
    String? content,
    leftStr = "取消",
    rightStr = "确定",
    Function? onCancel,
    Function? onConfirm,
  }) {
    showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
              title: ObjectUtil.isEmptyString(title) ? const SizedBox.shrink() : Text(title),
              content: ObjectUtil.isEmptyString(content) ? const SizedBox.shrink() : Text(content!),
              actions: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    child: Text(leftStr),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    child: Text(rightStr),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                  ),
                ),
              ],
            ));
  }

  /// Future<int> _showBasicModalBottomSheet(context, List<String> options) async {
  static void showBasicModalBottomSheet(List<Widget> actions, double height,
      {bgColor = Colors.white, leftStr = "取消", rightStr = "保存", Function? onCancel, Function? onConfirm}) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Container())),
            Container(
              height: 54,
              decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancel?.call();
                      },
                      child: Text(leftStr, style: const TextStyle(fontSize: 15, color: AppColors.color_f20, fontWeight: FontWeight.bold))),
                  Expanded(child: Container()),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm?.call();
                      },
                      child: Text(rightStr, style: const TextStyle(fontSize: 15, color: AppColors.primary, fontWeight: FontWeight.bold)))
                ],
              ),
            ),
            // const Divider(height: 0.5, color: AppColors.color_ea),
            Container(
              height: height,
              color: bgColor,
              child: ListView.builder(
                itemCount: actions.length,
                itemBuilder: (BuildContext context, int index) {
                  return actions[index];
                },
              ),
            )
          ],
        );
      },
    );
  }

  ///用户隐私协议弹框
  static void showProtocolFunction(
      {required Widget child, double height = 240, title = "", leftStr = "不同意", rightStr = "同意", Function? onCancel, Function? onConfirm}) {
    showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Container(
              height: height,
              child: SingleChildScrollView(child: child),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(leftStr),
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
              ),
              CupertinoDialogAction(
                child: Text(rightStr),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
              )
            ],
          );
        });
  }

  ///地址 地区城市三级联动ios样式选择弹窗
// static void showAddressPicker(double height, {bgColor = Colors.white, leftStr = "取消", rightStr = "保存", Function? onCancel, Function? onConfirm}) {
//   showModalBottomSheet<int>(
//     backgroundColor: Colors.transparent,
//     isScrollControlled: false,
//     context: Get.context!,
//     builder: (BuildContext context) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     onCancel?.call();
//                   },
//                   child: Container())),
//           Container(
//             height: 54,
//             decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))),
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       onCancel?.call();
//                     },
//                     child: Text(leftStr, style: const TextStyle(fontSize: 15, color: AppColors.color_f20, fontWeight: FontWeight.bold))),
//                 Expanded(child: Container()),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       onConfirm?.call();
//                     },
//                     child: Text(rightStr, style: const TextStyle(fontSize: 15, color: AppColors.primary, fontWeight: FontWeight.bold)))
//               ],
//             ),
//           ),
//           // const Divider(height: 0.5, color: AppColors.color_ea),
//           Container(
//             height: height,
//             color: bgColor,
//             child: AddressPicker(
//               style: const TextStyle(color: Colors.black, fontSize: 15),
//               mode: AddressPickerMode.provinceCityAndDistrict,
//               onSelectedAddressChanged: (address) {
//                 print('${address.currentProvince.name}');
//                 print('${address.currentCity.name}');
//                 print('${address.currentDistrict.name}');
//               },
//             ),
//           )
//         ],
//       );
//     },
//   );
// }
}
