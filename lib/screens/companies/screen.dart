import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/companies/contact_info_card.dart';
import 'package:daleelakappx/screens/companies/header.dart';
import 'package:daleelakappx/screens/companies/portfolio_card.dart';
import 'package:daleelakappx/screens/companies/reviews_card.dart';
import 'package:daleelakappx/screens/companies/summary_card.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class CompanyDetailsScreen extends StatefulWidget {
  static const String descriptionText =
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit.';

  final String id;

  const CompanyDetailsScreen(this.id, {super.key});

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  Future<Storefront> storefront = Completer<Storefront>().future;

  @override
  void initState() {
    storefront = api.storefronts.findOne(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: FutureBuilder(
          future: storefront,
          initialData: Storefront.dummyData()[0],
          builder: (context, snapshot) {
            return Skeletonizer(
              enabled: snapshot.connectionState != ConnectionState.done,
              child: DColumn(
                mainAxisSpacing: DBox.lgSpace,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(storefront: snapshot.data!),
                  SummaryCard(
                    descriptionText: snapshot.data!.description,
                    operatingHours: snapshot.data!.operatingHours,
                  ),
                  ContactInfoCard(storefront: snapshot.data!),
                  if (snapshot.data!.portfolioImages != null &&
                      snapshot.data!.portfolioImages!.isNotEmpty)
                    PortfolioCard(imageUrls: snapshot.data!.portfolioImages),
                  ReviewsCard(storefront: snapshot.data!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
