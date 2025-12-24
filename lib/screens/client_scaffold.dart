import 'package:daleelakappx/screens/screen_background.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class ClientScaffold extends StatelessWidget {
  final Widget child;
  final int pageIndex;
  final Function(int newPage) onPageChange;

  const ClientScaffold({
    super.key,
    required this.child,
    required this.pageIndex,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    Color? bgColor;
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
              BottomNavigationBarItem(label: 'search', icon: DIcons.search),
              BottomNavigationBarItem(label: 'label', icon: DIcons.category),
              BottomNavigationBarItem(label: 'bookmark', icon: DIcons.bookmark),
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
