import 'dart:async';
import 'package:get/get.dart';

import '../../common/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsView extends StatefulWidget {
  final StreamController streamController;

  const VideoDetailsView({Key? key, required this.streamController}) : super(key: key);

  @override
  State<VideoDetailsView> createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {
  late VideoPlayerController _videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset("assets/video/ttt_you_leave.mp4")
      ..initialize().then((value) {
        // _videoPlayerController.play();
        setState(() {});
      })
      ..addListener(() {
        if (isPlay && !_videoPlayerController.value.isPlaying) {
          isPlay = false;
          setState(() {});
        }
        Duration current = _videoPlayerController.value.position;
        Duration total = _videoPlayerController.value.duration;
        _currentSlider = current.inMilliseconds / total.inMilliseconds;
        if (_opacity == 1.0) {
          _streamController.add(0);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
            // isPlay = false;
            // _videoPlayerController.pause();
            // setState(() {});
          },
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          ),
        )),
        _buildController(),
      ],
    );
  }

  late Timer _timer;
  double _opacity = 1.0;
  bool isFirst = true;

  Widget _buildController() {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1200),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opacity = 1.0;
          });
          _timer = Timer(const Duration(seconds: 3), () {
            setState(() {
              _opacity = 0.0;
            });
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
                    onTap: () {
                      if (_videoPlayerController.value.isPlaying) {
                        stopPlayVideo();
                        if (_timer.isActive) {
                          _timer.cancel();
                        }
                      } else {
                        startPlayVideo();
                        _timer = Timer(const Duration(seconds: 3), () {
                          setState(() {
                            _opacity = 0.0;
                          });
                        });
                      }
                    },
                    child: Center(
                      child: ClipOval(
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(gradient: RadialGradient(colors: [Colors.black, Colors.black.withOpacity(0.3)])),
                          child: Icon(
                            _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))),
            const Positioned(
              top: 10,
              left: 10,
              right: 10,
              height: 44,
              child: Text("维术鸭", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
            ),
            Positioned(bottom: 10, left: 10, right: 10, height: 60, child: _buildBottomController()),
          ],
        ),
      ),
    );
  }

  double _currentSlider = 0.0;
  final StreamController<int> _streamController = StreamController();

  Widget _buildBottomController() {
    if (isFirst) {
      return Container();
    }
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext cxt, AsyncSnapshot<dynamic> snapshot) {
          return Row(
            children: [
              Text(getTimeStr(_videoPlayerController.value.position), style: const TextStyle(color: Colors.white, fontSize: 14)),
              Expanded(
                  child: Slider(
                      value: _currentSlider,
                      min: 0.0,
                      max: 1.0,
                      inactiveColor: Colors.white,
                      activeColor: Colors.redAccent,
                      onChanged: (value) {
                        _currentSlider = value;
                        _videoPlayerController.seekTo(_videoPlayerController.value.duration * value);
                        setState(() {});
                      })),
              Text(getTimeStr(_videoPlayerController.value.duration), style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          );
        });
  }

  void startPlayVideo() {
    if (widget.streamController != null) widget.streamController.add(_videoPlayerController);
    isPlay = true;
    isFirst = false;
    //视频播放位置
    Duration position = _videoPlayerController.value.position;
    //视频总长度
    Duration duration = _videoPlayerController.value.duration;
    if (position == duration) {
      //播放完毕 再次点击播放 设置开始播放位置
      _videoPlayerController.seekTo(Duration.zero);
    }

    _videoPlayerController.play();
    setState(() {});
  }

  void stopPlayVideo() {
    _videoPlayerController.pause();
    isPlay = false;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _streamController.close();
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  String getTimeStr(Duration duration) {
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m".addZero();
    String sStr = "$s".addZero();
    return "$mStr:$sStr";
  }
}
