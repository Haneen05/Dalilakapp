import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Widget? action;

  const TitleRow({
    super.key,
    this.action,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final currentAction = action;
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: DBox.fontLg,
          ),
        ),
        Expanded(child: Container()),
        if (currentAction != null)
          DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xff94a3b8),
              fontSize: DBox.fontSm,
            ),
            child: currentAction,
          ),
      ],
    );
  }
}
