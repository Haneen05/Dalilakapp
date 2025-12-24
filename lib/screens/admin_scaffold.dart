import 'package:daleelakappx/screens/screen_background.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class AdminScaffold extends StatelessWidget {
  final Widget child;
  final int pageIndex;
  final Function(int newPage) onPageChange;

  const AdminScaffold({
    super.key,
    required this.child,
    required this.pageIndex,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    Color? bgColor = Colors.white;
    var routeName = ModalRoute.of(context)!.settings.name!;
    if (child is ScreenBackground) {
      bgColor = (child as ScreenBackground).bgColor();
    }
    return PopScope(
      canPop: pageIndex == 0,
      onPopInvokedWithResult: (popped, result) {
        if (!popped) {
          onPageChange(0);
        }
      },
      child: Scaffold(
        body: child,
        backgroundColor: bgColor,
        floatingActionButton: [
          '/',
          '/dashboard/storefronts',
          '/dashboard/featured',
          '/dashboard/offers'
        ].contains(routeName)
            ? FloatingActionButton(
                onPressed: () {
                  if (pageIndex == 1) {
                    Navigator.pushNamed(context, '/dashboard/admin/create');
                  } else if (routeName.contains('offers')) {
                    Navigator.pushNamed(context, '/dashboard/offers/create');
                  } else {
                    Navigator.pushNamed(
                        context, '/dashboard/storefronts/create');
                  }
                },
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFe2e8f0), width: 1),
            ),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(label: 'home', icon: DIcons.home),
              BottomNavigationBarItem(
                  label: 'settings', icon: Icon(Icons.settings)),
            ],
            onTap: (index) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              onPageChange(index);
            },
          ),
        ),
      ),
    );
  }
}
