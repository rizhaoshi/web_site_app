import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

void main() {
  runApp(createApp());
  //安卓如何不设置以下的，状态栏上会有一层灰色的蒙层
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //设置为透明// Color for Android
    // statusBarBrightness: Brightness.light// Dark == white status bar -- for IOS.
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

