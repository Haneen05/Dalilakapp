import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/empty_list.dart';
import 'package:daleelakappx/widgets/offer_card.dart';
import 'package:daleelakappx/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class ManageOffersScreen extends StatefulWidget {
  const ManageOffersScreen({super.key});

  @override
  State<ManageOffersScreen> createState() => _ManageOffersScreenState();
}

class _ManageOffersScreenState extends State<ManageOffersScreen> {
  var offers = Completer<List<Offer>>().future;
  List<Offer> filteredOffers = [];

  @override
  void initState() {
    _fetchOffers();
    super.initState();
  }

  void _fetchOffers() {
    offers = api.offers.findMany();
    offers.then((data) {
      setState(() {
        filteredOffers = data;
      });
    });
  }

  void _searchOffers(String query) {
    offers.then((data) {
      setState(() {
        filteredOffers = data
            .where((offer) =>
                offer.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
      });
    });
  }

  Future<void> refresh() async {
    setState(() => _fetchOffers());
    await offers;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopBarWidget(title: Text('Offers')),
              const DBox.verticalSpaceLg(),
              SearchBox(
                hintText: 'Search Offers',
                onSearch: _searchOffers,
              ),
              const DBox.verticalSpace2Xl(),
              FutureBuilder(
                future: offers,
                initialData: Offer.dummyData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (filteredOffers.isEmpty) {
                    return EmptyListWidget(
                      subtitle: const Text('CreateYourFirstOffer'),
                      action: DButton.outlined(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/dashboard/offers/create');
                        },
                        child: const Text('Let\'sGetStarted'),
                      ),
                    );
                  }

                  return Skeletonizer(
                    enabled: snapshot.connectionState != ConnectionState.done,
                    child: Column(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () async {
                            await Navigator.of(context)
                                .pushNamed('/dashboard/offers/create');
                            refresh();
                          },
                          label: const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('CreateOffer'),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_right),
                          iconAlignment: IconAlignment.end,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DBox.lgSpace,
                            ),
                            elevation: 1.0,
                            alignment: AlignmentDirectional.centerStart,
                            foregroundColor: Colors.black,
                            iconColor: const Color(0xff94a3b8),
                            side: const BorderSide(color: Color(0xff8a96a8)),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  DBox.borderRadiusMd,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const DBox.verticalSpaceXl(),
                        Column(
                          children: ListTile.divideTiles(
                            context: context,
                            color: const Color(0xffe2e8f0),
                            tiles: filteredOffers.map((item) {
                              return OfferCard(
                                elevated: false,
                                title: Text(item.name),
                                expiryDate: item.expiryDate,
                                starred: item.isFeatured,
                                imageUrl: item.image?.url,
                                onTap: () async {
                                  await Navigator.of(context).pushNamed(
                                      '/dashboard/offers/${item.id}');
                                  refresh();
                                },
                              );
                            }),
                          ).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
