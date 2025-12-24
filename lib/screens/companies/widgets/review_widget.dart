import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final Widget author;
  final String title;
  final int rating;
  final String details;

  const ReviewWidget({
    super.key,
    required this.title,
    required this.author,
    required this.rating,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DBox.lgSpace,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: textTheme.titleSmall!,
                  child: author,
                ),
              ),
              DRow(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < rating
                        ? colorScheme.primaryFixedDim
                        : const Color(0xfff0f0f0),
                  );
                }),
              ),
            ],
          ),
          const DBox.verticalSpaceLg(),
          Text(title),
          const DBox.verticalSpaceLg(),
          Text(
            details,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
