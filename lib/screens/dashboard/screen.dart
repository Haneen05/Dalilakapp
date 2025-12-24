import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/dashboard/admin/screen.dart';
import 'package:daleelakappx/screens/dashboard/index/screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final pages = const [
    IndexScreen(),
    AdminSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return pages[DProvider.of(context).pageIndex];
  }
}
