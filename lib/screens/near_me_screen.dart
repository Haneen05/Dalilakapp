import 'dart:async';

import 'package:daleelakappx/models/storefront.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/sub_category.dart';

class NearMeScreen extends StatefulWidget {
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> {
  var storefronts = Completer<List<Storefront>>().future;

  @override
  void initState() {
    storefronts = api.storefronts.findMany();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: const Text('Near Me')),
      body:  FutureBuilder(
        future: storefronts,
        initialData: Storefront.dummyData(),
        builder: (context, snapshot) {
          return Skeletonizer(
            enabled: snapshot.connectionState != ConnectionState.done,
            child: Column(
                children: snapshot.data!.map((item) {
                  print(item.toJson());
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: DBox.smSpace),
                    child: CompanyCard(
                      name: item.name,
                      title: Text(item.name),
                      image: item.image?.url,
                      subtitle: FutureBuilder(
                        future: item.subcategory,
                        initialData: Subcategory.dummyData()[0],
                        builder: (context, snapshot) {
                          return Text(snapshot.data?.name ?? '');
                        },
                      ),
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
                                  text: l10n.distance(0),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: l10n.statusAway,
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
                        Navigator.of(context).pushNamed('/companies/${item.id}');
                      },
                    ),
                  );
                }).toList()),
          );
        },
      ),
    );
  }
}
