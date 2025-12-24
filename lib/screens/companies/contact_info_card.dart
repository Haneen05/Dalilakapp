import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactInfoCard extends StatelessWidget {
  final Storefront storefront;

  const ContactInfoCard({
    super.key,
    required this.storefront,
  });

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
              l18n.contactInfo,
              style: const TextStyle(
                fontSize: DBox.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            const DBox.verticalSpaceMd(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormattedPhoneNumber(phoneNumber: storefront.phoneNumber),
                      Text(storefront.email),
                      Text(storefront.address),
                      Text(
                        storefront.website,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                DRow(
                  mainAxisSpacing: DBox.mdSpace,
                  children: [
                    if(storefront.facebookUrl.isNotEmpty)
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(storefront.facebookUrl)),
                      child: DIcons.facebook,
                    ),
                    if(storefront.instagramUrl.isNotEmpty)
                    InkWell(
                      onTap: () =>
                          launchUrl(Uri.parse(storefront.instagramUrl)),
                      child: DIcons.instagram,
                    ),
                    if(storefront.twitterUrl.isNotEmpty)
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(storefront.twitterUrl)),
                      child: DIcons.x,
                    ),
                    if(storefront.linkedinUrl.isNotEmpty)
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(storefront.linkedinUrl)),
                      child: DIcons.linkedin,
                    ),
                  ],
                )
              ],
            ),
            const DBox.verticalSpaceMd(),
            DRow(
              mainAxisSpacing: DBox.mdSpace,
              children: [
                DButton.elevatedIcon(
                  onPressed: () {
                    launchUrl(Uri.parse(storefront.googleMapsLink));
                  },
                  icon: const Icon(
                    Icons.pin_drop_outlined,
                    color: Color(0xff292929),
                  ),
                ),
                Expanded(
                  child: DButton.elevatedPrimary(
                    onPressed: () async {
                      final Uri phoneUri = Uri.parse('tel:${storefront.phoneNumber}');
                      await launchUrl(phoneUri);
                    },
                    label: const Text('GetInTouch'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormattedPhoneNumber extends StatelessWidget {
  final String phoneNumber;

  const FormattedPhoneNumber({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    if (phoneNumber.isEmpty || phoneNumber.length < 4) {
      return Text(phoneNumber);
    }

    String countryCode = phoneNumber.substring(0, 4);
    String remainingNumber = phoneNumber.substring(4);

    String formattedNumber = _formatPhoneNumber(remainingNumber);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: countryCode,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: formattedNumber,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format the phone number based on its length
  String _formatPhoneNumber(String remainingNumber) {
    if (remainingNumber.length == 6) {
      return ' ${remainingNumber.substring(0, 1)} ${remainingNumber.substring(1, 4)} ${remainingNumber.substring(4)}';
    } else if (remainingNumber.length == 7) {
      return ' ${remainingNumber.substring(0, 2)} ${remainingNumber.substring(2, 5)} ${remainingNumber.substring(5)}';
    } else if (remainingNumber.length == 8) {
      return ' ${remainingNumber.substring(0, 1)} ${remainingNumber.substring(1, 5)} ${remainingNumber.substring(5)}';
    } else if (remainingNumber.length == 9) {
      return ' ${remainingNumber.substring(0, 2)} ${remainingNumber.substring(2, 6)} ${remainingNumber.substring(6)}';
    } else if (remainingNumber.length == 10) {
      return ' ${remainingNumber.substring(0, 1)} ${remainingNumber.substring(1, 4)} ${remainingNumber.substring(4, 7)} ${remainingNumber.substring(7)}';
    } else if (remainingNumber.length == 11) {
      return ' ${remainingNumber.substring(0, 2)} ${remainingNumber.substring(2, 5)} ${remainingNumber.substring(5, 8)} ${remainingNumber.substring(8)}';
    } else if (remainingNumber.length == 12) {
      return ' ${remainingNumber.substring(0, 1)} ${remainingNumber.substring(1, 5)} ${remainingNumber.substring(5, 8)} ${remainingNumber.substring(8)}';
    } else if (remainingNumber.length == 13) {
      return ' ${remainingNumber.substring(0, 2)} ${remainingNumber.substring(2, 6)} ${remainingNumber.substring(6, 9)} ${remainingNumber.substring(9)}';
    } else {
      return ' ${remainingNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ')}';
    }
  }
}
