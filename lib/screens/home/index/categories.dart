import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/home/index/title_row.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class CategoriesWidget extends StatefulWidget {
  final bool fromSearch;
  const CategoriesWidget({super.key, this.fromSearch = false});

  @override
  State<CategoriesWidget> createState() {
    return CategoriesWidgetState();
  }
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  bool extended = false;
  Future<List<Category>> categoriesFuture = Completer<List<Category>>().future;

  @override
  void initState() {
    categoriesFuture = api.categories.findMany();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          if(!widget.fromSearch)
          TitleRow(
            title: l10n.categories,
            action: extended
                ? null
                : TextButton(
                    onPressed: () {
                      setState(() => extended = true);
                    },
                    child: Text(
                      l10n.viewAll,
                      style: const TextStyle(
                        color: Color(0xff94a3b8),
                        fontSize: DBox.fontSm,
                      ),
                    ),
                  ),
          ),
          if(!widget.fromSearch)
          const DBox.verticalSpaceXl(),
          FutureBuilder(
            future: categoriesFuture,
            initialData: Category.dummyData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('ErrorLoadingCategories, ${snapshot.error}');
              }

              return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: Column(
                    children: snapshot.data!
                        .take(widget.fromSearch ?snapshot.data!.length :  (extended ? snapshot.data!.length : 4))
                        .map((item) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: item.icon == null ?
                              CircleAvatar(child: Text(item.name.characters.first.toUpperCase()),backgroundColor: Colors.grey,)
                              : item.icon,
                          minVerticalPadding: 22.0,
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xff94a3b8),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/categories/${item.id}',
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ));
            },
          ),
          if(!widget.fromSearch)
          const DBox.verticalSpaceXl(),
          if(!widget.fromSearch)
          if (extended)
            TextButton(
              onPressed: () {
                setState(() => extended = false);
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Color(0xff94a3b8),
                  ),
                  Text(
                    'View Less',
                    style: TextStyle(
                      color: Color(0xff94a3b8),
                      fontSize: DBox.fontSm,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
