import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/utilities.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:daleelakappx/api.dart' as api;

import '../featured_card.dart';
import '../offer_information.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final offerInformationKey = GlobalKey<OfferInformationCardState>();
  final featuredCardKey = GlobalKey<FeaturedCardState>();

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
              const TopBarWidget(title: Text('Create Offer')),
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
                          onPressed: createOffer,
                          label: const Text('SaveOffer'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createOffer() async {
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

   Utilities().openSpinner(context);

    try {
      await api.offers.add(
        OfferCreateInput(
          name: offerInfo.input.name.text,
          tags: offerInfo.input.tags,
          url: offerInfo.input.url.text,
          expiryDate: offerInfo.input.expiryDate!,
          featured: featured.input.featured,
          featuredExpiryDate: featured.input.expiryDate,
        ),
        image: offerInfo.input.image,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Utilities().closeSpinner(context);
    }
  }


}
