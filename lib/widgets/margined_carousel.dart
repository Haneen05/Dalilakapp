import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// A wrapper for `CarouselSlider` with the purpose of adding margins between slides.
/// Applying margins to each slide can make the carousel size smaller.
/// However this widget only creates space between slides that appear only when sliding
class MarginedCarousel extends StatelessWidget {
  final double margin;
  final double? height;
  final double? width;
  final List<Widget> items;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const MarginedCarousel({
    super.key,
    required this.margin,
    required this.items,
    this.onPageChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Empty box to set initial constraints for the stack size
        // and prevent the stack height to become infinite
        SizedBox(
          width: width,
          height: height,
        ),
        Positioned(
          left: -margin,
          right: -margin,
          child: CarouselSlider(
            items: items,
            options: CarouselOptions(
              viewportFraction: 1,
              height: height,
              onPageChanged: onPageChanged,
            ),
          ),
        ),
      ],
    );
  }
}
