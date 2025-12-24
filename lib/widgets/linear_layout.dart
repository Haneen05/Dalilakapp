import 'package:flutter/material.dart';

abstract class DLinearLayout extends StatelessWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final double mainAxisSpacing;

  const DLinearLayout({
    super.key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.mainAxisSpacing = 0.0,
    this.children = const <Widget>[],
  });

  List<Widget> spaceTiles() {
    var tiles = List.of(children);

    if (tiles.isEmpty || tiles.length == 1) {
      return tiles;
    }

    List<Widget> wrapTile(Widget tile) {
      return [
        tile,
        direction == Axis.vertical
            ? SizedBox(height: mainAxisSpacing)
            : SizedBox(width: mainAxisSpacing),
      ];
    }

    return <Widget>[
      ...tiles.take(tiles.length - 1).expand(wrapTile),
      tiles.last,
    ];
  }
}
