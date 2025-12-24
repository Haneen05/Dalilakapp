import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryCard extends StatelessWidget {
  final OperatingHours operatingHours;

  const SummaryCard({
    super.key,
    required this.descriptionText,
    required this.operatingHours,
  });

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l18n.description,
              style: const TextStyle(
                fontSize: DBox.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            const DBox.verticalSpaceMd(),
            Text(
              descriptionText,
              style: const TextStyle(
                color: Color(0xff6d6d6d),
              ),
            ),
            const DBox.verticalSpaceXl(),
            Text(
              l18n.operatingHours,
              style: const TextStyle(
                fontSize: DBox.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            const DBox.verticalSpaceMd(),
            Table(
                children: operatingHours.values().map((item) {
              final (day, operationWindow) = item;
              return TableRow(
                children: [
                  TableCell(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableCell(
                    child: operationWindow != null && operationWindow.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: operationWindow.map((window) {
                              return Text(window.formattedTime());
                            }).toList(),
                          )
                        : const Text(
                            'Closed',
                            textAlign: TextAlign.start,
                          ),
                  ),
                ],
              );
            }).toList()),
          ],
        ),
      ),
    );
  }
}
