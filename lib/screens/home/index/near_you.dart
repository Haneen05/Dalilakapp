import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/screens/home/index/title_row.dart';
import 'package:daleelakappx/screens/near_me_screen.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class NearYou extends StatefulWidget {
  const NearYou({super.key});

  @override
  State<NearYou> createState() => _NearYouState();
}

class _NearYouState extends State<NearYou> {
  var storefronts = Completer<List<Storefront>>().future;

  @override
  void initState() {
    storefronts = api.storefronts.findMany(limit: 3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleRow(
          title: l10n.nearYou,
          action: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NearMeScreen()),
              );
            },
            child: Text(l10n.viewAll),
          ),
        ),
        const DBox.verticalSpaceLg(),
        FutureBuilder(
          future: storefronts,
          initialData: Storefront.dummyData(),
          builder: (context, snapshot) {
            return Skeletonizer(
              enabled: snapshot.connectionState != ConnectionState.done,
              child: Column(
                  children: snapshot.data!.map((item) {
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
      ],
    );
  }
}
