import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/home/index/screen.dart';
import 'package:daleelakappx/screens/home/offers/screen.dart';
import 'package:daleelakappx/screens/home/saved/screen.dart';
import 'package:daleelakappx/screens/home/search/screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final pages = const [
    IndexScreen(),
    SearchScreen(),
    OffersScreen(),
    SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return pages[DProvider
        .of(context)
        .pageIndex];
  }
}
