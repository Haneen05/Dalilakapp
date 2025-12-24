import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  const CarouselDots({
    super.key,
    required this.itemsCount,
    required this.currentSlide,
  });

  final int itemsCount;
  final int currentSlide;

  @override
  Widget build(BuildContext context) {
    return DRow(
      mainAxisSpacing: DBox.smSpace,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemsCount, (index) {
        return CircleAvatar(
          backgroundColor:
              currentSlide == index ? Colors.black : const Color(0xff94a3b8),
          radius: 3.0,
        );
      }),
    );
  }
}
