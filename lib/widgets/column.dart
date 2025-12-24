import 'package:daleelakappx/widgets/linear_layout.dart';
import 'package:flutter/material.dart';

class DColumn extends DLinearLayout {
  const DColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.mainAxisSpacing,
    super.children,
  }) : super(direction: Axis.vertical);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spaceTiles(),
    );
  }
}
