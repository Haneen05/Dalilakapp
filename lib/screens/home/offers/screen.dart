import 'dart:async';

import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'offer_display.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  var offers = Completer<List<Offer>>().future;


  @override
  void initState() {
    offers = api.offers.findMany();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l18 = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const DBox.verticalSpaceMd(),
            // SearchBox(
            //   viewFilter: false,
            //   onSubmitted:(value) {
            //
            //   },
            //   onFocusChange: (hasFocus) {
            //     if (hasFocus) {
            //       DProvider.of(context).setPageIndex(2);
            //     }
            //   },
            //   onFiltersPressed: () {
            //     DProvider.of(context).setPageIndex(1);
            //   },
            //   title: l18.offers,
            // ),
            const DBox.verticalSpaceXl(),
            FutureBuilder(
              future: offers,
              initialData: Offer.dummyData(),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: DColumn(
                    mainAxisSpacing: 10.0,
                    children: snapshot.data!.map((item) {
                      return OfferDisplayWidget(offer: item);
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
