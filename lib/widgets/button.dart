import 'package:flutter/material.dart';

class DButton extends StatelessWidget {
  final WidgetBuilder builder;

  const DButton._({super.key, required this.builder});

  factory DButton.elevatedIcon({
    Key? key,
    required Widget icon,
    required VoidCallback? onPressed,
    Color backgroundColor = const Color(0xffe9e9e9),
  }) {
    return DButton._(
      key: key,
      builder: (context) {
        return ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shadowColor: const Color(0xff94a3b8),
          ),
          label: icon,
        );
      },
    );
  }

  factory DButton.elevated({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Color backgroundColor = const Color(0xffe9e9e9),
    Color? foregroundColor,
  }) {
    return DButton._(
      key: key,
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shadowColor: const Color(0xff94a3b8),
          ),
          child: DefaultTextStyle(
            style: textTheme.bodyMedium!.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          ),
        );
      },
    );
  }

  factory DButton.elevatedPrimary({
    Key? key,
    required Widget label,
    required VoidCallback? onPressed,
    Color backgroundColor = const Color(0xfff9da42),
    Color foregroundColor = Colors.black,
  }) {
    return DButton._(
      key: key,
      builder: (context) {
        return ElevatedButton.icon(
          onPressed: onPressed,
          label: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyle(
              style: TextStyle(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
              ),
              child: label,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_right),
          iconAlignment: IconAlignment.end,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
        );
      },
    );
  }

  factory DButton.primaryFilled({
    required VoidCallback? onPressed,
    required Widget label,
    Color backgroundColor = const Color(0xff0b0b0b),
    Color foregroundColor = Colors.white,
  }) {
    return DButton._(
      builder: (context) {
        return FilledButton.icon(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            alignment: AlignmentDirectional.centerStart,
            backgroundColor: backgroundColor,
            iconColor: foregroundColor,
          ),
          label: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyle(
              style: TextStyle(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
              ),
              child: label,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_right),
          iconAlignment: IconAlignment.end,
        );
      },
    );
  }

  factory DButton.filled({
    required VoidCallback? onPressed,
    required Widget child,
    Color backgroundColor = const Color(0xff0b0b0b),
    Color foregroundColor = Colors.white,
  }) {
    return DButton._(
      builder: (context) {
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: child,
        );
      },
    );
  }

  factory DButton.outlined({
    required VoidCallback? onPressed,
    required Widget child,
    Color foregroundColor = Colors.black,
    Color? backgroundColor,
    Color borderColor = const Color(0xffe0e0e0),
  }) {
    return DButton._(
      builder: (context) {
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: borderColor,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }

  factory DButton.text({
    required Widget child,
    required VoidCallback? onPressed,
  }) {
    return DButton._(
      builder: (context) {
        return TextButton(
          onPressed: onPressed,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
