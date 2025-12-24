import 'package:daleelakappx/screens/storefronts/portfolio.dart';
import 'package:daleelakappx/utilities.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:daleelakappx/models.dart';
import '../contact_info.dart';
import '../featured.dart';
import '../general_info.dart';
import '../operating_hours.dart';
import 'package:daleelakappx/widgets.dart';

class CreateStorefrontScreen extends StatefulWidget {
  const CreateStorefrontScreen({super.key});

  @override
  State<CreateStorefrontScreen> createState() => _CreateStorefrontScreenState();
}

class _CreateStorefrontScreenState extends State<CreateStorefrontScreen> {
  final generalInfoKey = GlobalKey<GeneralInformationCardState>();
  final contactInfoKey = GlobalKey<ContactInformationCardState>();
  final operatingHoursKey = GlobalKey<OperatingHoursCardState>();
  final portfolioImagesKey = GlobalKey<PortfolioImagesInputState>();
  final featuredKey = GlobalKey<FeaturedCardState>();

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
          child: DColumn(
            mainAxisSpacing: 8.0,
            children: [
              const TopBarWidget(title: Text('Create Storefront')),
              DColumn(
                mainAxisSpacing: 25.0,
                children: [
                  GeneralInformationCard(key: generalInfoKey),
                  OperatingHoursCard(key: operatingHoursKey),
                  ContactInformationCard(key: contactInfoKey),
                  PortfolioImagesInput(key: portfolioImagesKey),
                  FeaturedCard(key: featuredKey),
                  DColumn(
                    mainAxisSpacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                              onPressed: createStorefront,
                              label: const Text('SaveStoreFront'),
                            ),
                          ),
                        ],
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

  Future<void> createStorefront() async {
    final generalInfo = generalInfoKey.currentState!;
    final contactInfo = contactInfoKey.currentState!;
    final operatingHours = operatingHoursKey.currentState!;
    final portfolioImages = portfolioImagesKey.currentState!;
    final featured = featuredKey.currentState!;

    if (!generalInfo.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PleaseCorrectInvalidFields'),
          backgroundColor: Color(0xffe16060),
        ),
      );
      Scrollable.ensureVisible(generalInfo.context);
      return;
    }

    Utilities().openSpinner(context);

    try {
      final imageUrls = await portfolioImages.uploadImages();

      await api.storefronts.add(
        StorefrontCreateInput(
          name: generalInfo.input.name.text,
          description: generalInfo.input.description.text,
          email: contactInfo.input.email.text,
          address: contactInfo.input.address.text,
          googleMapsLink: contactInfo.input.googleMapsLink.text,
          phoneNumber: contactInfo.input.phoneNumber.text,
          website: contactInfo.input.website.text,
          facebookUrl: contactInfo.input.facebookUrl.text,
          instagramUrl: contactInfo.input.instagramUrl.text,
          twitterUrl: contactInfo.input.twitterUrl.text,
          linkedinUrl: contactInfo.input.linkedinUrl.text,
          showOperatingHours: operatingHours.input.showOperatingHours,
          operatingHours: OperatingHours.fromInput(operatingHours.input),
          tags: generalInfo.input.tags,
          subcategoryId: generalInfo.input.subcategoryId,
          featured: featured.input.featured,
          featuredExpiryDate: featured.input.expiryDate,
          portfolioImages: imageUrls,
        ),
        image: generalInfo.input.image,
      );

      if (mounted) {
        Navigator.of(context)
            .pop(true);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
     Utilities().closeSpinner(context);
    }
  }

}
