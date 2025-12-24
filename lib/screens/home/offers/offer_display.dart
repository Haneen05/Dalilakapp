import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDisplayWidget extends StatelessWidget {
  final Offer offer;

  const OfferDisplayWidget({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final image = offer.image;
    return Stack(
      children: [
        Container(
          height: 168.0,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
            borderRadius: const BorderRadius.all(
              Radius.circular(DBox.borderRadiusMd),
            ),
          ),
          child: image != null
              ? Image.network(
                  image.url,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(DBox.borderRadiusMd),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                launchUrl(Uri.parse(offer.url));
              },
            ),
          ),
        )
      ],
    );
  }
}
