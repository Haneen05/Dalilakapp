import 'dart:async';

import 'package:daleelakappx/screens/home/index/categories.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/home/search/search_filters.dart';
import 'package:daleelakappx/screens/home/search/search_history.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/screens/home/index/title_row.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool filtersOpen = false;
  late Future<List<Storefront>> storefronts;
  List<Storefront>? filteredResults;
  final historyWidgetKey = GlobalKey<SearchHistoryWidgetState>();
  final searchBoxKey = GlobalKey<SearchBoxState>();
  bool isFocused = false;

  // Filter State
  SortOrder? sortOrder;
  String? selectedLocation;
  String? selectedCategory;
  String? selectedSubCategory;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    storefronts = api.storefronts.findMany();
  }

  void search(String text, [bool addToHistory = true]) async {
    final query = text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => filteredResults = null);
      return;
    }

    if (addToHistory) {
      historyWidgetKey.currentState?.addItem(text);
    }

    final allStorefronts = await storefronts;

    setState(() {
      searchText = text;
      filteredResults = allStorefronts.where((storefront) {
        final name = storefront.name.toLowerCase();
        final description = storefront.description.toLowerCase();
        final tags = storefront.tags.map((tag) => tag.toLowerCase()).toList();

        return name.contains(query) ||
            description.contains(query) ||
            tags.contains(query);
      }).toList();
    });
  }

  void _applyFilters(Map<String, dynamic> filters) async {

      sortOrder = filters['sortOrder'];
      selectedLocation = filters['address'];
      selectedCategory = filters['category'];
      selectedSubCategory = filters['subCategory'];
      final allStorefronts = await storefronts;
      print(allStorefronts.length);

      filteredResults = await Future.wait(
        allStorefronts.map((storefront) async {
          bool matches = true;

          if (selectedLocation != null) {
            matches &= storefront.address.contains(selectedLocation!);
          }

          final subcategory = await storefront.subcategory;

          if (selectedSubCategory != null) {
            print(subcategory!.id);
            if (subcategory!.id != selectedSubCategory) {
              return null;
            }
          }

          return storefront;
        }),
      ).then((list) => list.whereType<Storefront>().toList()); // Remove nulls

      if (sortOrder == SortOrder.ascending) {
        filteredResults?.sort((a, b) => a.name.compareTo(b.name));
      } else if (sortOrder == SortOrder.descending) {
        filteredResults?.sort((a, b) => b.name.compareTo(a.name));
      }

      filtersOpen = false;
      setState(() {
    });
  }

  void _clearFilters() {
    setState(() {
      sortOrder = null;
      selectedLocation = null;
      selectedCategory = null;
      selectedSubCategory = null;
      filteredResults = null;
      filtersOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l18 = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: DColumn(
          mainAxisSpacing: DBox.xlSpace,
          children: [
            SearchBox(
              key: searchBoxKey,
              autoFocus: isFocused,
              title: l18.search,
              filtersActive: filtersOpen,
              onFiltersPressed: () {
                setState(() => filtersOpen = !filtersOpen);
              },
              onSubmitted: (text) => search(text.trim()),
              onFocusChange: (_){
                setState(() {
                  isFocused = !isFocused;
                });
              },
            ),
        AnimatedSize(
        duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: filtersOpen
    ? DColumn(
    mainAxisSpacing: DBox.lgSpace,
    children: [
    TitleRow(
    title: l18.previousSearch,
    action: TextButton(
    onPressed: _clearFilters,
    child: Text(l18.clearAll),
    ),
    ),
    SearchFiltersWidget(
    onApplyFilters: _applyFilters,
    onClearFilters: _clearFilters,
    initialSortOrder: sortOrder,
    initialLocation: selectedLocation,
    initialCategory: selectedCategory,
    initialSubCategory: selectedSubCategory,
    ),
    ],
    )
        : const SizedBox(),
    ),
    if (filteredResults != null && filteredResults!.isEmpty && !filtersOpen)
              const Text('NoResults')
            else if (filteredResults != null)
              DColumn(
                mainAxisSpacing: 8.0,
                children: filteredResults!.map((storefront) {
                  return CompanyCard(
                    name: storefront.name,
                    title: Text(storefront.name),
                    subtitle: FutureBuilder<Subcategory>(
                      future: storefront.subcategory.then((subcategory) =>
                          subcategory ?? Subcategory.dummyData()[0]),
                      initialData: Subcategory.dummyData()[0],
                      builder: (context, snapshot) {
                        return Text(snapshot.data?.name ?? '');
                      },
                    ),
                    image: storefront.image?.url,
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/companies/${storefront.id}');
                    },
                    featured: storefront.featured,
                    elevated: true,
                  );
                }).toList(),
              )
            else if(isFocused)
              SearchHistoryWidget(
                key: historyWidgetKey,
                onItemClick: (text) {
                  searchBoxKey.currentState?.setText(text);
                  search(text, false);
                },
              ),
            if(!isFocused && !filtersOpen)
           const CategoriesWidget(
              fromSearch: true,
            )
          ],
        ),
      ),
    );
  }
}
