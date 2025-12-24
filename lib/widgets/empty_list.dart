import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmptyListWidget extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? action;

  const EmptyListWidget({
    super.key,
    this.title = const Text('Oops!NothingToShowYet'),
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    final title = Text(l18n.oops);
    final subtitle = this.subtitle;
    final action = this.action;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: DBox.fontLg,
              ),
          child: title,
        ),
        const DBox.verticalSpaceMd(),
        if (subtitle != null) subtitle,
        const DBox.verticalSpace2Xl(),
        if (action != null) action,
      ],
    );
  }
}
