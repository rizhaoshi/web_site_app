import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'common/config/app_thumb.dart';

Widget createApp() {
  return GetMaterialApp(
    initialRoute: Routes.MAIN,
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
    theme: theme,
  );
}
