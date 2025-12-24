import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class ReviewsSummary extends StatelessWidget {
  final ReviewStats reviewStats;

  const ReviewsSummary({
    required this.reviewStats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DRow(
          mainAxisSpacing: DBox.smSpace,
          children: [
            Text(
              reviewStats.average.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: DBox.fontXl,
              ),
            ),
            const Icon(
              Icons.star,
              color: Color(0xffffb400),
            )
          ],
        ),
        Text(
          '${reviewStats.total} Reviews',
          style: TextStyle(color: Colors.black.withOpacity(0.38)),
        ),
      ],
    );
  }
}
