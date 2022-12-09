import 'package:flutter/material.dart';

import '../../routes/navigation_utils.dart';
import '../login/login_page.dart';

class MineNoLoginPage extends StatefulWidget {
  const MineNoLoginPage({Key? key}) : super(key: key);

  @override
  State<MineNoLoginPage> createState() => _MineNoLoginPageState();
}

class _MineNoLoginPageState extends State<MineNoLoginPage> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.cyan,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              //按下
              setState(() {
                isDown = true;
              });
            },
            onTapCancel: () {
              //移出
              setState(() {
                isDown = false;
              });
            },
            onTap: () {
              NavigatorUtils.pushPageByFade(context: context, starMills: 1200, targetPage: LoginPage());
            },
            child: Hero(
              tag: "logo",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      boxShadow: isDown ? [const BoxShadow(color: Colors.black, offset: Offset(3, 4), blurRadius: 13)] : null),
                  child: const Text(
                    "登录",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
