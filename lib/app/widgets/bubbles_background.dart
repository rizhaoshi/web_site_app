import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BubblesBackground extends StatefulWidget {
  const BubblesBackground({Key? key}) : super(key: key);

  @override
  State<BubblesBackground> createState() => _BubblesBackgroundState();
}

//获取颜色
Color getRandomWhiteColor(Random random) {
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class _BubblesBackgroundState extends State<BubblesBackground> with TickerProviderStateMixin {
  //气泡集合
  final List<BobbleBean> _list = [];

  //随机数
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  //运动最大速度
  final double _maxSpeed = 1.0;

  //运动最大半径
  final double _maxRadius = 80;

  //运动最大角度
  final double _maxTheta = 2 * pi;

  //动画控制器
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 15; i++) {
      BobbleBean bean = BobbleBean();
      bean.color = getRandomWhiteColor(_random);
      bean.postion = const Offset(-1, -1);
      bean.speed = _maxSpeed * _random.nextDouble();
      bean.radius = _maxRadius * _random.nextDouble();
      bean.theta = _maxTheta * _random.nextDouble();
      _list.add(bean);
    }

    _animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {});
      });
    _animation.repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _buildBackground(),
            _buildBubbleView(context),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Container(color: Colors.white.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
              //渐变开始方向
              begin: Alignment.topLeft,
              //渐变的结束方向
              end: Alignment.bottomRight,
              //渐变数组
              colors: [Colors.lightBlueAccent.withOpacity(0.3), Colors.lightBlue.withOpacity(0.3), Colors.blue.withOpacity(0.3)])),
    );
  }

  Widget _buildBubbleView(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: CustomBubblePainter(list: _list, random: _random),
    );
  }
}

class CustomBubblePainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;

  CustomBubblePainter({required this.random, required this.list});

  final Paint _paint = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    list.forEach((element) {
      Offset newCenterOffset = calculateXY(element.speed, element.theta);
      double dx = newCenterOffset.dx + element.postion.dx;
      double dy = newCenterOffset.dy + element.postion.dy;

      if (dx < 0 || dx > size.width) {
        dx = random.nextDouble() * size.width;
      }

      if (dy < 0 || dy > size.height) {
        dy = random.nextDouble() * size.height;
      }
      element.postion = Offset(dx, dy);
    });

    //绘制
    list.forEach((element) {
      _paint.color = element.color;
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }
}

class CustomHeaderClipper extends CustomClipper<Path> {
  double progress = 0.0;

  CustomHeaderClipper(this.progress);

  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.8);
    //修改控制点
    double controllerCenterx = size.width * 0.5 + (size.width * 0.6 + 1) * sin(progress * pi);
    double controllerCentery = size.height * 0.8 + 70 * sin(progress * pi);
    path.quadraticBezierTo(controllerCenterx, controllerCentery, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class BobbleBean {
  //位置
  late Offset postion;

  //颜色
  late Color color;

  //运动速度
  late double speed;

  //运动角度
  late double theta;

  //半径
  late double radius;
}
