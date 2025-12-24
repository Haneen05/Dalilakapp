import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesListingScreen extends StatefulWidget {
  final String id;

  const CategoriesListingScreen(this.id, {super.key});

  @override
  State<CategoriesListingScreen> createState() =>
      _CategoriesListingScreenState();
}

class _CategoriesListingScreenState extends State<CategoriesListingScreen> {
  var subcategory = Completer<Subcategory>().future;
  var storefronts = Completer<List<Storefront>>().future;

  @override
  void initState() {
    subcategory = api.subcategories.findOne(widget.id);
    storefronts = api.storefronts.findMany(subcategoryId: widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l18 = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: Column(
          children: [
            FutureBuilder(
              future: subcategory,
              initialData: Subcategory.dummyData()[0],
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: SearchBox(
                    title: snapshot.data!.name,
                    backButton: true,
                    searchHint: l18.searchForSubCategory,
                  ),
                );
              },
            ),
            const DBox.verticalSpaceXl(),
            FutureBuilder(
              future: storefronts,
              initialData: Storefront.dummyData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: DColumn(
                    mainAxisSpacing: DBox.mdSpace,
                    children: snapshot.data!
                        .map(
                          (item) => CompanyCard(
                            name: item.name,
                            image: item.image?.url,
                            title: Text(item.name),
                            subtitle: FutureBuilder(
                              future: item.subcategory,
                              initialData: null,
                              builder: (context, snapshot) {
                                return Text(snapshot.data?.name ?? '');
                              },
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/companies/${item.id}');
                            },
                            additionalInfo: Row(
                              children: [
                                Icon(Icons.pin_drop_rounded),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: DBox.fontSm,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: l18.distance(0),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: ' '),
                                      TextSpan(
                                        text: l18.statusAway,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
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
