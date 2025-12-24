import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class OfferCard extends StatelessWidget {
  final bool elevated;
  final Widget title;
  final bool starred;
  final DateTime? expiryDate;
  final VoidCallback? onTap;
  final String? imageUrl;

  const OfferCard({
    super.key,
    required this.title,
    required this.expiryDate,
    this.elevated = true,
    this.starred = false,
    this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = DefaultTextStyle.of(context).style;
    final expiryDate = this.expiryDate;
    final imageUrl = this.imageUrl;
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: elevated ? 1.0 : 0.0,
        color: elevated ? Colors.white : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(DBox.borderRadiusLg),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: elevated ? DBox.smSpace : DBox.lgSpace,
            horizontal: DBox.smSpace,
          ),
          child: SizedBox(
            height: 75.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 144.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DBox.borderRadiusMd),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                const DBox.horizontalSpaceLg(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        child: title,
                      ),
                      const Expanded(child: SizedBox()),
                      if (expiryDate != null)
                        Text(
                          formatExpiresIn(expiryDate),
                          style: const TextStyle(
                            fontSize: DBox.fontSm,
                          ),
                        ),
                    ],
                  ),
                ),
                const DBox.horizontalSpaceLg(),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xff94a3b8),
                      ),
                    ),
                    if (starred)
                      const Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Icon(
                          Icons.star,
                          color: Color(0xfff9da42),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatExpiresIn(DateTime date) {
    String prefix = 'Expires in';
    if (DateTime.now().isAfter(date)) {
      prefix = 'Expired';
    }
    return '$prefix ${timeago.format(date, allowFromNow: true).replaceAll('from now', '')}';
  }
}
