import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/config/url_config.dart';
import '../../../common/storage/storage_constant.dart';
import '../../../common/storage/storage_util.dart';
import '../../../common/utils/common_util.dart';
import '../../../common/utils/dialog_util.dart';
import '../../../common/widgets/permission_request_page.dart';
import '../../routes/navigation_utils.dart';
import 'first_guild_page.dart';
import 'splash_controller.dart';
import 'welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  SplashController controller = Get.find<SplashController>();

  final List<String> _list = [
    "为您更好的体验应用,所以需要获取您手机的文件存储权限,以保存您的一些偏好设置",
    "您已拒绝权限,请在设置中心中同意App的权限请求",
    "您以拒绝权限,所以无法保存您的一些偏好设置,将无法使用App",
    "其它错误",
  ];

  @override
  void initState() {
    super.initState();
    //延时一秒
    Future.delayed(Duration.zero, () {
      initData();
    });
  }

  void initData() {
    NavigatorUtils.pushPageByFade(
        context: context,
        targetPage: PermissionRequestPage(
          permission: Permission.storage,
          list: _list,
          isCloseApp: true,
          leftStr: "退出App",
        ),
        dismissCallBack: (value) async {
          if (value == null || !value) {
            //允许
          } else {
            //请求不通过
          }
          bool? isAgrement = await StorageUtil.instance.getBool(StorageConstant.IS_AGREMENT);
          if (isAgrement == null || !isAgrement) {
            initDataNext();
          } else {
            _next();
          }
        });
  }

  void initDataNext() {
    DialogUtil.showProtocolFunction(
        child: _buildProtocolContent(),
        title: "温馨提示",
        onCancel: () {
          _closeApp();
        },
        onConfirm: () {
          StorageUtil.instance.putBool(StorageConstant.IS_AGREMENT, true);
          _next();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          CommonUtils.getImageByName("img_mn_01"),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _closeApp() {
    //退出应用
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  //协议说明文案
  String userPrivateProtocol =
      "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。本协议（包括本文最后部分的隐私政策）是用户（包括通过各种合法途径获取到本产品的自然人、法人或其他组织机构，以下简称“用户”或“您”）与我们之间针对本产品相关事项最终的、完整的且排他的协议，并取代、合并之前的当事人之间关于上述事项的讨论和协议。本协议将对用户使用本产品的行为产生法律约束力，您已承诺和保证有权利和能力订立本协议。用户开始使用本产品将视为已经接受本协议，请认真阅读并理解本协议中各种条款，包括免除和限制我们的免责条款和对用户的权利限制（未成年人审阅时应由法定监护人陪同），如果您不能接受本协议中的全部条款，请勿开始使用本产品";
  String user_agreement = "《用户协议》";
  String register_privacy = "《隐私协议》";

  Widget _buildProtocolContent() {
    return RichText(
      //文字居中
      textAlign: TextAlign.center,
      //文字区域
      text: TextSpan(
        text: "请您本产品之前，请务必仔细阅读并理解",
        style: TextStyle(color: Colors.grey[600]),
        children: [
          TextSpan(
            text: user_agreement,
            style: const TextStyle(color: Colors.blue),
            //点击事件
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //打开用户协议
                controller.onPushWebPage(UrlConfig.USER_AGREEMENT, user_agreement, [const SizedBox(width: 50)]);
              },
          ),
          TextSpan(
            text: "和",
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextSpan(
            text: register_privacy,
            style: const TextStyle(color: Colors.blue),
            //点击事件
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //打开隐私协议
                controller.onPushWebPage(UrlConfig.PRIVACY_PROTOCOL, register_privacy, [const SizedBox(width: 50)]);
              },
          ),
          //后续显示的文本内容
          TextSpan(text: userPrivateProtocol)
        ],
      ),
    );
  }

  void _next() async {
    StorageUtil.instance.getBool(StorageConstant.IS_FIRST).then((value) {
      if (value == null||!value) {
        NavigatorUtils.pushPageByFade(context: context, targetPage: FirstGuildPage(), isReplace: true);
      } else {
        NavigatorUtils.pushPageByFade(context: context, targetPage: WelcomePage(), isReplace: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
