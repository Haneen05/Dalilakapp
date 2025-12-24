import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesScreen extends StatefulWidget {
  final String id;

  const CategoriesScreen(this.id, {super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Subcategory>> subcategories =
      Completer<List<Subcategory>>().future;

  Future<Category> category = Completer<Category>().future;

  @override
  void initState() {
    category = api.categories.findOne(widget.id);
    subcategories = api.subcategories.findMany(categoryId: widget.id);

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
              future: category,
              initialData: Category.dummyData()[0],
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
              future: subcategories,
              initialData: Subcategory.dummyData(),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: Column(
                    children: ListTile.divideTiles(
                      context: context,
                      color: const Color(0xffe2e8f0),
                      tiles: snapshot.data!.map((item) {
                        return ListTile(
                          title: Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: DBox.fontMd,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/categories/${item.id}/companies');
                          },
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xff94a3b8),
                            size: DBox.fontLg,
                          ),
                        );
                      }),
                    ).toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
