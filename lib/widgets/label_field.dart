import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class LabelField extends StatelessWidget {
  final Widget label;
  final Widget input;
  final Widget? helperText;

  const LabelField({
    super.key,
    required this.label,
    required this.input,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    final helperText = this.helperText;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultTextStyle(
          style: const TextStyle(
            color: Color(0xff4f4f4f),
          ),
          child: label,
        ),
        const DBox.verticalSpaceMd(),
        input,
        if (helperText != null) const DBox.verticalSpaceSm(),
        if (helperText != null)
          DefaultTextStyle(
            style: textTheme.bodySmall!.copyWith(
              color: const Color(0xff828282),
            ),
            child: helperText,
          ),
      ],
    );
  }
}
