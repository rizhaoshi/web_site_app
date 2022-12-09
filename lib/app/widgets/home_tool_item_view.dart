import 'package:flutter/material.dart';

import '../../common/utils/common_util.dart';

class HomeToolItemView extends StatefulWidget {
  const HomeToolItemView({Key? key}) : super(key: key);

  @override
  State<HomeToolItemView> createState() => _HomeToolItemViewState();
}

class _HomeToolItemViewState extends State<HomeToolItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.orangeAccent.withOpacity(0.6),
        Colors.white,
      ])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 12),
            child: const Text("Basics_Flutter基础框架", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [Icon(Icons.forward_10), SizedBox(width: 12), Text("维术鸭", style: TextStyle(fontWeight: FontWeight.bold))],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12, top: 5),
                        child: Text(
                          "高洁的灵魂淤泥里见，不堪的人格溢满视野。落日沉溺于橘色的海，晚风沦陷于赤诚的爱。我洗的不是脚,而是世上的泥泞!",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Image.asset(
                      CommonUtils.getIconByName("ic_basics_logo"),
                      width: 98,
                      height: 98,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
