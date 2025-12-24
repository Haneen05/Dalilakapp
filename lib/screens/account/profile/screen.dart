import 'package:daleelakappx/screens/account/profile/profile_form.dart';
import 'package:daleelakappx/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TopBarWidget(title: Text(l18n.profile)),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: ProfileFormWidget(constraints: constraints),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
