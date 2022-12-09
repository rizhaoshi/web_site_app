import 'dart:async';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../common/utils/log_util.dart';

class HomeController extends GetxController {
  StreamController streamController = StreamController.broadcast();
  VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/video/ttt_you_leave.mp4");
  bool isScaffold = false;

  @override
  void onInit() {
    super.onInit();
    streamController.stream.listen((event) {
      LogUtil.i("HomeController onInit", "接收到msg");
      if (videoPlayerController != null && videoPlayerController.textureId != event.textureId) {
        videoPlayerController.pause();
      }
      videoPlayerController = event;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    streamController.close();
    super.dispose();
  }

  void setScaffold(bool scaffold) {
    isScaffold = scaffold;
    update();
  }
}
