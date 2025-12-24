import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/home/index/categories.dart';
import 'package:daleelakappx/screens/home/index/header.dart';
import 'package:daleelakappx/screens/home/index/near_you.dart';
import 'package:daleelakappx/screens/home/index/reach_out.dart';
import 'package:daleelakappx/screens/home/index/top_offers.dart';
import 'package:daleelakappx/screens/home/search_box.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderWidget(),
            const DBox.verticalSpaceMd(),
            SearchBox(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  DProvider.of(context).setPageIndex(1);
                }
              },
              onFiltersPressed: () {
                DProvider.of(context).setPageIndex(1);
              },
              titleAlignment: AlignmentDirectional.centerStart,
              title: l10n.searchBoxTitle,
            ),
            const DBox.verticalSpaceXl(),
            const CategoriesWidget(),
            const DBox.verticalSpaceXl(),
            const TopOffersWidget(),
            const DBox.verticalSpaceXl(),
            const NearYou(),
            const DBox.verticalSpaceXl(),
            const ReachOutWidget(),
          ],
        ),
      ),
    );
  }
}
