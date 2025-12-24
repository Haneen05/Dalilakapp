import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:daleelakappx/widgets/carousel_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PortfolioCard extends StatefulWidget {
  final List<String>? imageUrls;

  const PortfolioCard({super.key, required this.imageUrls});

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l18n.portfolio,
                    style: const TextStyle(
                      fontSize: DBox.fontLg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty)
                  CarouselDots(
                    itemsCount: widget.imageUrls!.length,
                    currentSlide: currentSlide,
                  ),
              ],
            ),
            const DBox.verticalSpaceLg(),
            if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty)
              MarginedCarousel(
                margin: DBox.mdSpace,
                width: MediaQuery.of(context).size.width,
                height: 168.0,
                items: widget.imageUrls!.map((url) {
                  return SizedBox.expand(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: DBox.mdSpace,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(DBox.borderRadiusMd),
                        ),
                        color: Theme.of(context).colorScheme.surfaceDim,
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onPageChanged: (page, reason) {
                  setState(() => currentSlide = page);
                },
              ),
          ],
        ),
      ),
    );
  }
}
