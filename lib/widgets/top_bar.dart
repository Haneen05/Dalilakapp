import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  final Widget title;

  const TopBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = DefaultTextStyle.of(context).style;
    return IntrinsicHeight(
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Center(
            child: DefaultTextStyle(
              style: textStyle.copyWith(
                fontSize: DBox.fontLg,
                fontWeight: FontWeight.bold,
              ),
              child: title,
            ),
          ),
        ],
      ),
    );
  }
}
