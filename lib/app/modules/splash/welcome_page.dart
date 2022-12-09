import 'package:flutter/material.dart';
import '../../widgets/welcome_time_view.dart';
import 'Welcome_video_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: const [
            Positioned.fill(child: WelcomeVideoPage()),
            Positioned(right: 25, top: 56, child: WelcomeTimeView()),
          ],
        ),
      ),
    );
  }
}
