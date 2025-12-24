import 'dart:async';

import 'package:daleelakappx/api.dart' as api;
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:daleelakappx/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  DUser? user;
  var storefronts = Completer<List<Storefront>>().future;
  List<Storefront> filteredStored = [];

  @override
  // void initState() {
  //   didChangeDependencies();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    final user = this.user = DProvider.of(context).user;

    if (user != null) {
      storefronts = api.users.getSavedStorefronts(user.id);
    } else {
      storefronts = Future.value([]);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;

    final user = this.user;
    final l18n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DBox.verticalSpaceMd(),
            SearchBox(
              viewFilter: false,
              onSubmitted: (value) {
                storefronts.then((data) {
                  setState(() {
                    filteredStored = data
                        .where((offer) => offer.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList()
                      ..sort((a, b) => a.name.compareTo(b.name));
                  });
                });
              },
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  DProvider.of(context).setPageIndex(3);
                }
              },
              onFiltersPressed: () {
                DProvider.of(context).setPageIndex(1);
              },
              title: l18n.myList,
            ),
            const DBox.verticalSpaceXl(),
            if (user != null)
              FutureBuilder(
                future: filteredStored.isNotEmpty
                    ? Future.value(filteredStored)
                    : storefronts,
                initialData: Storefront.dummyData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SelectableText(snapshot.error.toString());
                  }

                  if (snapshot.data!.isEmpty) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 300,
                      ),
                      child: Center(
                        child: EmptyListWidget(
                          subtitle: Text(l18n.findSavedStorefronts),
                        ),
                      ),
                    );
                  }

                  return Skeletonizer(
                    enabled: snapshot.connectionState != ConnectionState.done,
                    child: Column(
                        children: snapshot.data!.map((storefront) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: DBox.smSpace),
                        child: CompanyCard(
                          name: storefront.name,
                          title: Text(storefront.name),
                          image: storefront.image?.url,
                          subtitle: FutureBuilder(
                            future: storefront.subcategory,
                            initialData: null,
                            builder: (context, snapshot) {
                              return Text(snapshot.data?.name ?? '');
                            },
                          ),
                          additionalInfo: const Row(
                            children: [
                              Icon(Icons.pin_drop_rounded),
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: DBox.fontSm,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '0.00 Km',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: 'away',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/companies/${storefront.id}');
                          },
                        ),
                      );
                    }).toList()),
                  );
                },
              )
            else
               Center(
                child: Text(_locale.loginToYourFavoriteStoreFrontsHere),
              ),
          ],
        ),
      ),
    );
  }
}
