import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Widget widget;
  final Duration duration;
  final double? wigetHeight;
  const ScrollToHideWidget(
      {super.key,
      required this.scrollController,
      required this.widget,
      this.wigetHeight,
      this.duration = const Duration(microseconds: 150)});

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisiable = true;
  @override
  void initState() {
    widget.scrollController.addListener(listen);
    super.initState();
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisiable) {
      setState(() {
        isVisiable = true;
      });
    }
  }

  void hide() {
    if (isVisiable) {
      setState(() {
        isVisiable = false;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height:
            isVisiable ? widget.wigetHeight ?? kBottomNavigationBarHeight : 0,
        child: Wrap(children: [widget.widget]),
      );
}
