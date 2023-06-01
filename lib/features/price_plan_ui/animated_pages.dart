import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef ChildBuilder = Widget Function(int index, BuildContext context);
typedef OnPageChangeCallback = void Function(int index);

class AnimatedPages extends StatelessWidget {
  final PageController pageController;
  final double pageValue;
  final ChildBuilder child;
  final int pageCount;
  final OnPageChangeCallback onPageChangeCallback;

  const AnimatedPages({
    Key? key,
    required this.pageController,
    required this.pageValue,
    required this.child,
    required this.pageCount,
    required this.onPageChangeCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChangeCallback,
      physics: const ClampingScrollPhysics(),
      controller: pageController,
      itemCount: pageCount,
      itemBuilder: (context, index) {
        if (index == pageValue.floor() + 1 || index == pageValue.floor() + 2) {
          /// Right
          return Transform.translate(
            offset:
                Offset(-100.0 * (index - pageValue), 60 * (index - pageValue)),
            child: Transform.rotate(
              angle: -math.pi / -11 * (index - pageValue),
              child: child(
                index,
                context,
              ),
            ),
          );
        } else if (index == pageValue.floor() ||
            index == pageValue.floor() - 1) {
          /// Left
          return Transform.translate(
            offset:
                Offset(-100.0 * (index - pageValue), 60 * (pageValue - index)),
            child: Transform.rotate(
              angle: -math.pi / -11 * (index - pageValue),
              child: child(index, context),
            ),
          );
        } else {
          /// Middle
          return child(index, context);
        }
      },
    );
  }
}
