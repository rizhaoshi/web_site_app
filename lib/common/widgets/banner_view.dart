import 'package:flutter/material.dart';
import '../utils/common_util.dart';

class BannerView extends StatefulWidget {
  double height;
  int currentIndex;
  final List<String> images;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onTap;
  int maxCount = 2000000;
  PageController pageController;

  BannerView({
    Key? key,
    this.height = 115.0,
    this.currentIndex = 0,
    required this.images,
    required this.pageController,
    required this.onPageChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        height: widget.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
                onPageChanged: (index) {
                  widget.onPageChanged(index);
                },
                itemCount: widget.maxCount,
                controller: widget.pageController,
                itemBuilder: (ctx, index) {
                  double scaleValue = index == widget.currentIndex ? 1.0 : 0.86;
                  return InkWell(
                      onTap: () {
                        widget.onTap(index);
                      },
                      child: TweenAnimationBuilder(
                          tween: Tween(begin: scaleValue, end: scaleValue),
                          duration: const Duration(milliseconds: 300),
                          builder: (ctx, value, _) {
                            return Transform.scale(
                              scale: scaleValue,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: CommonUtils.getImageByName("common_img_login"),
                                    image: widget.images[index % widget.images.length],
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }));
                }),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) => Indicator(isActivity: index == widget.currentIndex % widget.images.length)),
              ),
            )
          ],
        ));
  }
}

class Indicator extends StatelessWidget {
  bool isActivity;

  Indicator({Key? key, this.isActivity = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActivity ? 14.0 : 7.0,
      height: 4.0,
      decoration: BoxDecoration(color: isActivity ? Colors.white : Colors.white70, borderRadius: BorderRadius.circular(5)),
      duration: const Duration(milliseconds: 300),
    );
  }
}
