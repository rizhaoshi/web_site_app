import 'package:flutter/material.dart';

import '../../../common/storage/storage_constant.dart';
import '../../../common/storage/storage_util.dart';
import '../../../common/utils/common_util.dart';
import '../../routes/navigation_utils.dart';
import '../main/main_page.dart';

class FirstGuildPage extends StatefulWidget {
  const FirstGuildPage({Key? key}) : super(key: key);

  @override
  State<FirstGuildPage> createState() => _FirstGuildPageState();
}

class _FirstGuildPageState extends State<FirstGuildPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              children: [
                Image.asset(CommonUtils.getImageByName("img_mn_01"), width: width, height: height, fit: BoxFit.fill),
                Image.asset(CommonUtils.getImageByName("img_mn_02"), width: width, height: height, fit: BoxFit.fill),
                Image.asset(CommonUtils.getImageByName("img_mn_03"), width: width, height: height, fit: BoxFit.fill),
                Image.asset(CommonUtils.getImageByName("img_mn_04"), width: width, height: height, fit: BoxFit.fill),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndefot(_currentIndex == 0),
                _buildIndefot(_currentIndex == 1),
                _buildIndefot(_currentIndex == 2),
                _buildIndefot(_currentIndex == 3),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            height: 44,
            child: _buildToHome(),
          ),
        ],
      ),
    );
  }

  Widget _buildIndefot(bool isSelect) {
    return AnimatedContainer(
      height: 10,
      width: isSelect ? 20 : 10,
      margin: const EdgeInsets.only(left: 12),
      duration: const Duration(milliseconds: 800),
      decoration: const BoxDecoration(color: Colors.deepOrangeAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  Widget _buildToHome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          width: _currentIndex == 3 ? 44 : 0,
          height: _currentIndex == 3 ? 180 : 0,
          child: ElevatedButton(
            onPressed: () {
              StorageUtil.instance.putBool(StorageConstant.IS_FIRST, true);
              NavigatorUtils.pushPageByFade(context: context, targetPage: MainPage(), isReplace: true);
            },
            child: Text("去首页"),
          ),
        )
      ],
    );
  }
}
