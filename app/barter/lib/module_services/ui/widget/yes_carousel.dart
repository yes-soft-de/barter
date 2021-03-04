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
      height: 180,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            bottom: 12,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor, width: 4),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            bottom: 4,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_getIndicator()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIndicator() {
    var circles = <Widget>[];
    for (int i = 0; i < widget.cards.length; i++) {
      circles.add(Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: i <= currentIndex
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                shape: BoxShape.circle),
          ),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: circles,
      ),
    );
  }
}
