
import 'package:flutter/material.dart';

import '../../routes/navigation_utils.dart';
import 'settings/settings_page.dart';

class MineLoginPage extends StatefulWidget {
  const MineLoginPage({Key? key}) : super(key: key);

  @override
  State<MineLoginPage> createState() => _MineLoginPageState();
}

class _MineLoginPageState extends State<MineLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.cyan,
      child: Stack(
        children: [
          Positioned(
              top: 56,
              right: 16,
              child: InkWell(
                onTap: () {
                  NavigatorUtils.pushPageByFade(context: context, starMills: 1200, targetPage: SettingsPage());
                },
                child: const Icon(Icons.settings, size: 26, color: Colors.black),
              ))
        ],
      ),
    );
  }
}
