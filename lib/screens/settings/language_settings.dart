import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/language_provider.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.languageSettings),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ListView(
            children: [
              RadioListTile<String>(
                title: Text(l10n.english),
                value: 'en',
                groupValue: languageProvider.currentLocale.languageCode,
                onChanged: (String? value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value);
                  }
                },
              ),
              RadioListTile<String>(
                title: Text(l10n.arabic),
                value: 'ar',
                groupValue: languageProvider.currentLocale.languageCode,
                onChanged: (String? value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
