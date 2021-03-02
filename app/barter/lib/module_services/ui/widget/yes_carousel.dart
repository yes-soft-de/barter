import 'package:flutter/material.dart';

class YesCarousel extends StatefulWidget {
  final List<Widget> cards;
  final bool autoPlay;
  final Duration slideDuration;

  YesCarousel({this.cards, this.autoPlay = true, this.slideDuration});

  @override
  State<StatefulWidget> createState() => _YesCarouselState();
}

class _YesCarouselState extends State<YesCarousel> {
  int currentIndex = 0;
  Duration viewDuration;
  final _carouselController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    if (widget.autoPlay) {
      if (widget.slideDuration == null) {
        viewDuration = Duration(seconds: 5);
      } else {
        viewDuration = widget.slideDuration;
      }
      Future.delayed(viewDuration, () {
        _carouselController.animateToPage(
          currentIndex % widget.cards.length,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    }
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: PageView(
                  controller: _carouselController,
                  onPageChanged: (pos) {
                    currentIndex = pos;
                    if (mounted) setState(() {});
                  },
                  pageSnapping: true,
                  children: widget.cards,
                ),
              ),
            ),
          ),
          Positioned(
            child: _getIndicator(),
            bottom: 8,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget _getIndicator() {
    var circles = <Widget>[];
    for (int i = 0; i < widget.cards.length; i++) {
      circles.add(Container(
        height: 8,
        width: 8,
        color: i <= currentIndex ? Theme.of(context).primaryColor : Colors.grey,
      ));
    }
    return Container(
      width: 16,
      height: 16,
      alignment: Alignment.center,
      child: Flex(
        direction: Axis.horizontal,
        children: circles,
      ),
    );
  }
}
