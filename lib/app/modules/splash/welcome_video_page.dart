import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WelcomeVideoPage extends StatefulWidget {
  const WelcomeVideoPage({Key? key}) : super(key: key);

  @override
  State<WelcomeVideoPage> createState() => _WelcomeVideoPageState();
}

class _WelcomeVideoPageState extends State<WelcomeVideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset("assets/video/apologize_mv.mp4")
      ..initialize().then((value) {
        _videoPlayerController.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
