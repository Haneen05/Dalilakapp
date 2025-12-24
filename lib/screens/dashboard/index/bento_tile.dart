import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class BentoTile extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final VoidCallback? onTap;
  final AssetImage image;

  const BentoTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      color: const Color(0xffe9e9e9),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(DBox.xlSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(Icons.open_in_new),
                  ),
                  const Expanded(child: SizedBox()),
                  FloatingActionButton(
                    heroTag: 'bento-$label',
                    onPressed: null,
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    child: icon,
                  ),
                  const DBox.verticalSpaceXl(),
                  const Text('ManageYour'),
                  DefaultTextStyle(
                    style: textTheme.titleLarge!,
                    child: label,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
