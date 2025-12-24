import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/home/index/title_row.dart';
import 'package:daleelakappx/screens/home/offers/offer_display.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/carousel_dots.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopOffersWidget extends StatefulWidget {
  const TopOffersWidget({super.key});

  @override
  State<TopOffersWidget> createState() => _TopOffersWidgetState();
}

class _TopOffersWidgetState extends State<TopOffersWidget> {
  var offers = Completer<List<Offer>>().future;
  int currentSlide = 0;

  @override
  void initState() {
    offers = api.offers.findMany(limit: 4);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TitleRow(
          title: l10n.topOffers,
          action: TextButton(
            onPressed: () {
              DProvider.of(context).setPageIndex(2);
            },
            child: Text(l10n.viewAll),
          ),
        ),
        const DBox.verticalSpaceLg(),
        FutureBuilder(
          future: offers,
          initialData: Offer.dummyData(),
          builder: (context, snapshot) {
            return Skeletonizer(
              enabled: snapshot.connectionState != ConnectionState.done,
              child: Column(
                children: [
                  MarginedCarousel(
                    margin: DBox.mdSpace,
                    width: MediaQuery.of(context).size.width,
                    height: 168.0,
                    onPageChanged: (index, _) {
                      setState(() => currentSlide = index);
                    },
                    items: snapshot.data!.map((item) {
                      return SizedBox.expand(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: DBox.mdSpace,
                          ),
                          child: OfferDisplayWidget(offer: item),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(DBox.xlSpace),
                    child: CarouselDots(
                      itemsCount: snapshot.data!.length,
                      currentSlide: currentSlide,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
