import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/providers/language_provider.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/screens/settings/language_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:provider/provider.dart';

class ProfileFormWidget extends StatefulWidget {
  final BoxConstraints constraints;

  const ProfileFormWidget({
    super.key,
    required this.constraints,
  });

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  DUser? user;
  var input = UserInput();

  @override
  void didChangeDependencies() {
    this.user = DProvider.of(context).user;

    final user = this.user;
    if (user != null) {
      mapFrom(user);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = this.user;
    final l10n = AppLocalizations.of(context)!;

    if (user == null) {
      return Center(
        child: Text(l10n.notLoggedIn),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Language Settings Button
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguageSettingsScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.language, size: 24),
                const DBox.horizontalSpaceMd(),
                Text(
                  l10n.languageSettings,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
        const Divider(color: Colors.grey),
        const DBox.verticalSpace2Xl(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person_outline, size: 26),
            const DBox.horizontalSpaceMd(),
            Text(
              l10n.userInfo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: DBox.fontLg,
              ),
            ),
          ],
        ),
        const DBox.verticalSpace2Xl(),
        DColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSpacing: DBox.xlSpace,
          children: [
            LabelField(
              label: Text(l10n.userName),
              input: TextField(
                decoration: InputDecoration(hintText: l10n.userName),
                controller: input.name,
              ),
            ),
            LabelField(
              label: Text(l10n.phoneNumber),
              input: TextField(
                readOnly: true,
                decoration: InputDecoration(hintText: l10n.phoneNumber),
                controller: TextEditingController(text: user.phoneNumber),
              ),
            ),
            LabelField(
              label: Text(l10n.selectGender),
              input: DropdownMenu(
                width: widget.constraints.maxWidth,
                hintText: l10n.gender,
                initialSelection: input.gender?.name,
                onSelected: (gender) {
                  if (gender != null) {
                    setState(() => input.gender = Gender.of(gender));
                  }
                },
                dropdownMenuEntries: Gender.values.map((elem) {
                  return DropdownMenuEntry(
                    value: elem.name,
                    label: elem.uiName,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const DBox.verticalSpace3Xl(),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.cancel),
            ),
            const DBox.horizontalSpaceMd(),
            Expanded(
              child: FilledButton.icon(
                onPressed: saveProfile,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsetsDirectional.only(
                      start: DBox.lgSpace, end: 0.0),
                  alignment: AlignmentDirectional.centerStart,
                  backgroundColor: const Color(0xff0b0b0b),
                  iconColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        DBox.borderRadiusMd,
                      ),
                    ),
                  ),
                ),
                label: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    l10n.saveProfile,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_right),
                iconAlignment: IconAlignment.end,
              ),
            ),
          ],
        ),
        const DBox.verticalSpaceMd(),
        Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return SizedBox(
              width: double.infinity,
              child: DButton.elevated(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  languageProvider.changeLanguage('en');
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffe16060),
                child: DRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.logout),
                    const Icon(Icons.logout_outlined),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void mapFrom(DUser user) {
    setState(() {
      input.name.text = user.name;
      input.phoneNumber = user.phoneNumber ?? '';
      input.gender = user.gender;
    });
  }

  Future<void> saveProfile() async {
    final user = this.user;
    if (user != null) {
      await api.users.update(
        user.id,
        DUserInput(
          uid: user.uid,
          name: input.name.text,
          phoneNumber: user.phoneNumber,
          gender: input.gender,
          role: user.role,
        ),
      );

      if (mounted) {
        Navigator.of(context).pop();
        DProvider.of(context).refetchUser();
      }
    }
  }
}

class UserInput {
  TextEditingController name = TextEditingController(text: '');
  String phoneNumber = '';
  Gender? gender;
}
