import 'package:daleelakappx/models.dart';
import 'package:flutter/material.dart';

class DProvider extends InheritedWidget {
  final int pageIndex;
  final DUser? user;
  final Function(int) setPageIndex;
  final VoidCallback refetchUser;

  const DProvider({
    super.key,
    required super.child,
    required this.pageIndex,
    required this.setPageIndex,
    required this.refetchUser,
    this.user,
  });

  @override
  bool updateShouldNotify(covariant DProvider oldWidget) {
    return oldWidget.pageIndex != pageIndex || oldWidget.user != user;
  }

  static DProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DProvider>();
  }

  static DProvider of(BuildContext context) {
    final DProvider? result = maybeOf(context);
    assert(result != null, 'No DalilakProvider found in context');
    return result!;
  }
}
