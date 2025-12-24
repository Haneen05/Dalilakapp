import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  final bool elevated;
  final Widget title;
  final Widget subtitle;
  final Widget? additionalInfo;
  final bool featured;
  final VoidCallback? onTap;
  final String? image;
  final String name;

  const CompanyCard({
    super.key,
    this.elevated = true,
    required this.title,
    required this.subtitle,
    this.additionalInfo,
    this.featured = false,
    this.onTap,
    this.image, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final additionalInfo = this.additionalInfo;
    var textStyle = DefaultTextStyle.of(context).style;
    final image = this.image;
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: elevated ? 1.0 : 0.0,
        color: elevated ? Colors.white : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(DBox.borderRadiusLg),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: elevated ? DBox.smSpace : DBox.lgSpace,
            horizontal: DBox.smSpace,
          ),
          child: SizedBox(
            height: 75.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 75.0,
                  height: 75.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DBox.borderRadiusMd),
                    ),
                  ),
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      :  CircleAvatar(child: Text(name.characters.first.toUpperCase(), style: TextStyle(color: Colors.white),),backgroundColor: Colors.grey,)

                ),
                const DBox.horizontalSpaceLg(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        child: title,
                      ),
                      DefaultTextStyle(
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: DBox.fontSm,
                        ),
                        child: subtitle,
                      ),
                      const DBox.verticalSpaceMd(),
                      if (additionalInfo != null) additionalInfo,
                    ],
                  ),
                ),
                const DBox.horizontalSpaceLg(),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xff94a3b8),
                    ),
                    if (featured)
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff9da42),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: 2.0,
                          ),
                          child: const Text(
                            'FEATURED',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
