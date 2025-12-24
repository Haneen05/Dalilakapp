import 'package:daleelakappx/screens/dashboard/admin_search_box.dart';
import 'package:daleelakappx/screens/dashboard/index/bento_tile.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Dalilak\nDashboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Expanded(child: SizedBox()),
                DButton.text(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: DRow(
                    mainAxisSpacing: 11.0,
                    children: [
                      Text(
                        'Logout',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Icon(Icons.logout, color: Color(0xff292929)),
                    ],
                  ),
                ),
              ],
            ),
            // const DBox.verticalSpace2Xl(),
            // const AdminSearchBox(),
            const DBox.verticalSpace2Xl(),
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: DBox.smSpace,
              crossAxisSpacing: DBox.smSpace,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1.5,
                  child: BentoTile(
                    label: const Text('StoreFronts'),
                    icon: const Icon(Icons.store_outlined),
                    image: const AssetImage('assets/images/storefronts.jpg'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/dashboard/storefronts');
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1.5,
                  child: BentoTile(
                    label: const Text('Featured'),
                    image: const AssetImage('assets/images/featured.jpeg'),
                    icon: const Icon(Icons.star_outline),
                    onTap: () {
                      Navigator.of(context).pushNamed('/dashboard/featured');
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1.5,
                  child: BentoTile(
                    label: const Text('Offers'),
                    icon: const Icon(Icons.discount_outlined),
                    image: const AssetImage('assets/images/offers.jpg'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/dashboard/offers');
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
