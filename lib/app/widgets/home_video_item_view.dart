import 'dart:async';
import '../../app/widgets/video_details_view.dart';
import '../../common/utils/common_util.dart';
import 'package:flutter/material.dart';

class HomeVideoItemView extends StatefulWidget {
  final StreamController streamController;
  bool scaffold;

  HomeVideoItemView({Key? key, required this.streamController, this.scaffold = false}) : super(key: key);

  @override
  State<HomeVideoItemView> createState() => _HomeVideoItemViewState();
}

class _HomeVideoItemViewState extends State<HomeVideoItemView> {
  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: Container(
        height: 200,
        child: widget.scaffold
            ? Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            CommonUtils.getImageByName("img_mn_02"),
            fit: BoxFit.fitWidth,
          ),
        )
            : VideoDetailsView(streamController: widget.streamController),
      ),
    );
  }
}
