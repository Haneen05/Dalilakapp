import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/dashboard/admin_search_box.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:daleelakappx/widgets/empty_list.dart';
import 'package:daleelakappx/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class ManageFeaturedScreen extends StatefulWidget {
  const ManageFeaturedScreen({super.key});

  @override
  State<ManageFeaturedScreen> createState() => _ManageFeaturedScreenState();
}

class _ManageFeaturedScreenState extends State<ManageFeaturedScreen> {
  var storefronts = Completer<List<Storefront>>().future;
  List<Storefront> filteredStorefronts = [];

  @override
  void initState() {
    _fetchStorefronts();
    super.initState();
  }

  void _fetchStorefronts() {
    storefronts = api.storefronts.findMany(featured: true);
    storefronts.then((data) {
      setState(() {
        filteredStorefronts = data;
      });
    });
  }

  void _searchStorefronts(String query) {
    storefronts.then((data) {
      setState(() {
        filteredStorefronts = data
            .where((storefront) =>
                storefront.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final minHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _fetchStorefronts());
        await storefronts;
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: IntrinsicHeight(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
              child: Column(
                children: [
                  const TopBarWidget(title: Text('Featured')),
                  const DBox.verticalSpaceLg(),
                  SearchBox(
                    hintText: 'Search Featured Storefronts',
                    onSearch: _searchStorefronts,
                  ),
                  const DBox.verticalSpace2Xl(),
                  FutureBuilder(
                    future: storefronts,
                    initialData: Storefront.dummyData(),
                    builder: (context, snapshot) {
                      return Skeletonizer(
                        enabled:
                            snapshot.connectionState != ConnectionState.done,
                        child: Builder(
                          builder: (context) {
                            final data = filteredStorefronts;

                            if (data.isEmpty) {
                              return Expanded(
                                child: EmptyListWidget(
                                  subtitle: const Text(
                                      'Create Your First Storefront'),
                                  action: DButton.outlined(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          '/dashboard/storefronts/create');
                                    },
                                    child: const Text('Let\'sGetStarted'),
                                  ),
                                ),
                              );
                            }

                            return Column(
                              children: ListTile.divideTiles(
                                context: context,
                                color: const Color(0xffe2e8f0),
                                tiles: data.map((item) {
                                  return CompanyCard(
                                    name: item.name,
                                    elevated: false,
                                    title: Text(item.name),
                                    subtitle: FutureBuilder(
                                        future: item.subcategory,
                                        initialData: Subcategory.dummyData()[0],
                                        builder: (context, snapshot) {
                                          return Text(
                                              snapshot.data?.name ?? '');
                                        }),
                                    featured: item.isFeatured,
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/dashboard/storefronts/${item.id}');
                                    },
                                  );
                                }),
                              ).toList(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
