import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class ReviewBar extends StatelessWidget {
  final double factor;

  const ReviewBar(this.factor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 8.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(DBox.borderRadiusSm),
            ),
            color: Color(0xfff0f0f0),
          ),
        ),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: factor,
          child: Container(
            height: 8.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(DBox.borderRadiusSm),
              ),
              color: Color(0xffffb400),
            ),
          ),
        ),
      ],
    );
  }
}
