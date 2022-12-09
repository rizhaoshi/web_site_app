import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class WelcomeTimeView extends StatefulWidget {
  const WelcomeTimeView({Key? key}) : super(key: key);

  @override
  State<WelcomeTimeView> createState() => _WelcomeTimeViewState();
}

class _WelcomeTimeViewState extends State<WelcomeTimeView> {
  int currentTime = 6;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime == 0) {
        _timer.cancel();
        _toMain();
        return;
      }
      currentTime--;
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {_toMain();},
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.redAccent, width: 2.0), borderRadius: const BorderRadius.all(Radius.circular(30))),
        width: 46,
        height: 46,
        alignment: Alignment.center,
        child: Text(
          "${currentTime}s",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
      ),
    );
  }

  void _toMain() {
    Get.offAndToNamed(Routes.MAIN);
  }
}
