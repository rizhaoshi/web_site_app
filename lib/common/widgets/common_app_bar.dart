import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final double? height;
  final Color? bgColor;

  const CommonAppBar({Key? key, this.height = 45.0, this.bgColor = AppColors.primary, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
      ),
      actions: actions,
      title: Center(
          child: Text(
        title ?? "",
        style: const TextStyle(fontSize: 18, color: AppColors.color_f20),
      )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
