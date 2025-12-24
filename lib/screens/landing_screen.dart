import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/dashboard/screen.dart';
import 'package:daleelakappx/screens/home/screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DProvider.of(context).user;
    return user?.role == Role.admin
        ? const DashboardScreen()
        : const HomeScreen();
  }
}
