import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/utils/common_util.dart';
import '../../../common/utils/toast_util.dart';
import '../../widgets/bubbles_background.dart';
import '../../widgets/text_field_view.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (cxt) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                const Positioned.fill(child: BubblesBackground()),
                Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                            tag: "logo",
                            child: Material(
                                color: Colors.transparent,
                                child: ClipOval(child: Image.asset(CommonUtils.getIconByName("ic_basics_logo"), width: 33, height: 33)))),
                        const SizedBox(width: 20),
                        const Text(
                          "欢迎登录",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.blueGrey),
                        )
                      ],
                    )),
                Positioned(
                    bottom: 64,
                    left: 40,
                    right: 40,
                    child: Column(
                      children: [
                        TextFieldView(
                          controller: controller.userPhoneController,
                          focusNode: controller.userPhoneFocusNode,
                          obscureText: false,
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "手机号",
                          submit: (value) {
                            if (value.length != 11) {
                              ToastUtil.toast(context, "请输入11位手机号");
                              FocusScope.of(context).requestFocus(controller.userPhoneFocusNode);
                              return;
                            }
                            controller.userPhoneFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(controller.userPasswordFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFieldView(
                          controller: controller.userPasswordController,
                          focusNode: controller.userPasswordFocusNode,
                          obscureText: controller.passwordShow,
                          prefixIcon: const Icon(Icons.lock_open_outlined),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.onPasswordShow();
                            },
                            child: Icon(controller.passwordShow ? Icons.visibility : Icons.visibility_off),
                          ),
                          hintText: "密码",
                          submit: (value) {
                            if (value.length < 6) {
                              ToastUtil.toast(context, "请输入6位以上密码");
                              FocusScope.of(context).requestFocus(controller.userPasswordFocusNode);
                              return;
                            }
                            controller.userPhoneFocusNode.unfocus();
                            controller.userPasswordFocusNode.unfocus();
                          },
                        ),
                        const SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.onToLogin(context);
                            },
                            child: const Text("登录", style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("注册", style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    top: 64,
                    left: 0,
                    child: CloseButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
