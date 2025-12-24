import 'package:daleelakappx/screens/screen_background.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

import 'create_admin.dart';

class CreateAdminScreen extends StatelessWidget implements ScreenBackground {
  const CreateAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final minHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: const IntrinsicHeight(
            child: Stack(
              children: [
                TopBarWidget(title: Text('Create Admin')),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CreateAdminForm(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Color bgColor() {
    return const Color(0xffe9e9e9);
  }
}
