import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff155EFF);
  static const Color primary_pass = Color(0x7D155EFF);
  static const Color active = Color(0xffF9FAFB);
  static const Color success = Color(0xff07c160);
  static const Color danger = Color(0xffee0a24);
  static const Color warning = Color(0xffffba00);
  static const Color info = Color(0xff00a1d6);
  static const Color page = Color(0xfff7f7f7);
  static const Color nav = Color(0xfffbfbfb);
  static const Color border = Color(0xfff5f5f5);
  static const Color black_15 = Color(0x26000000);

  static const Color light_gray = Color(0xffd3d3d3);
  static const Color color_text = Color(0xff333333);
  static const Color color_hint = Color(0xff666666);
  static const Color color_hint_two = Color(0xff999999);
  static const Color color_f20 = Color(0xff202020);
  static const Color color_d8 = Color(0xffd8d8d8);
  static const Color color_cc = Color(0xffcccccc);
  static const Color color_ea = Color(0xffeaeaea);
  static const Color color_f6 = Color(0xfff6f6f6);
  static const Color color_f579 = Color(0xfff5f7f9);
  static const Color color_e7ef = Color(0xffE7EEFF);
  static const Color color_f8ad = Color(0xffF8FAFD);
  static const Color color_cfe2 = Color(0xffCFE2FF);
  static const Color color_b4cf = Color(0xffB4CFFF);
  static const Color color_de8f = Color(0xffDDE8FF);
  static const Color color_f52 = Color(0xffFF5252);
  static const Color color_f249 = Color(0xffFF2449);


  // 颜色值转换
  static Color string2Color(String colorString) {
    int? value = 0x00000000;
    if (colorString.isNotEmpty) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16);
      if (value != null) {
        if (value < 0xFF000000) {
          value += 0xFF000000;
        }
      }
    }
    return Color(value!);
  }
}
