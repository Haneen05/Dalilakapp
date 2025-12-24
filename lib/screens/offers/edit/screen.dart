import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:daleelakappx/api.dart' as api;

import '../featured_card.dart';
import '../offer_information.dart';

class EditOfferScreen extends StatefulWidget {
  final String id;

  const EditOfferScreen(this.id, {super.key});

  @override
  State<EditOfferScreen> createState() => _EditOfferScreenState();
}

class _EditOfferScreenState extends State<EditOfferScreen> {
  final offerInformationKey = GlobalKey<OfferInformationCardState>();
  final featuredCardKey = GlobalKey<FeaturedCardState>();

  var offer = Completer<Offer>().future;

  @override
  void initState() {
    offer = api.offers.findOne(widget.id);

    offer.then((value) async {
      offerInformationKey.currentState!.mapFrom(value);
      featuredCardKey.currentState!.mapFrom(value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final minHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Container(
          color: const Color(0xffe9e9e9),
          padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
          child: Column(
            children: [
              const TopBarWidget(title: Text('Edit Offer')),
              const DBox.verticalSpaceXl(),
              StaggeredGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: DBox.xlSpace * 2,
                children: [
                  OfferInformationCard(key: offerInformationKey),
                  FeaturedCard(key: featuredCardKey),
                  DRow(
                    mainAxisSpacing: 17.0,
                    children: [
                      DButton.elevated(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.white,
                        child: const Text('Cancel'),
                      ),
                      Expanded(
                        child: DButton.elevatedPrimary(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          onPressed: editOffer,
                          label: const Text('SaveOffer'),
                        ),
                      ),
                    ],
                  ),
                  DButton.elevated(
                    backgroundColor: const Color(0xffe16060),
                    foregroundColor: Colors.white,
                    onPressed: confirmThenDelete,
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editOffer() async {
    final offerInfo = offerInformationKey.currentState!;
    final featured = featuredCardKey.currentState!;

    if (!offerInfo.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please correct invalid fields',
          ),
          backgroundColor: Color(0xffe16060),
        ),
      );
      Scrollable.ensureVisible(offerInfo.context);
      return;
    }

    try {
      await api.offers.update(
        widget.id,
        OfferCreateInput(
          name: offerInfo.input.name.text,
          url: offerInfo.input.url.text,
          tags: offerInfo.input.tags,
          expiryDate: offerInfo.input.expiryDate!,
          featured: featured.input.featured,
          featuredExpiryDate: featured.input.expiryDate,
        ),
        image: offerInfo.input.image,
        removeImage: offerInfo.input.existingImage == null,
      );

      if (mounted) {
        Navigator.of(context).popUntil((route) =>
            route.isFirst || route.settings.name == '/dashboard/offers');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> confirmThenDelete() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('DeleteOffer'),
          content: const Text('AreYouSureYouWantToDeleteThisOffer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xffe16060),
              ),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      await api.offers.delete(widget.id);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
