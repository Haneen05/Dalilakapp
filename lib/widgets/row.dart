import 'package:daleelakappx/widgets/linear_layout.dart';
import 'package:flutter/material.dart';

class DRow extends DLinearLayout {
  const DRow({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.mainAxisSpacing,
    super.children,
  }) : super(direction: Axis.horizontal);

  @override
  Widget build(BuildContext context) {
    return Row(
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
