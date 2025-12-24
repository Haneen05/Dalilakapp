import 'package:daleelakappx/models/storefront.dart';
import 'package:daleelakappx/screens/companies/widgets/review_bar.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class ReviewsByRatingSummary extends StatelessWidget {
  final ReviewStats reviewStats;

  const ReviewsByRatingSummary({
    required this.reviewStats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DColumn(
      mainAxisSpacing: DBox.mdSpace,
      children: reviewStats.percentages.indexed.map(
        (item) {
          final (index, value) = item;
          return DefaultTextStyle(
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text((index + 1).toString()),
                const DBox.horizontalSpaceMd(),
                Expanded(child: ReviewBar(value)),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
