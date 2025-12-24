import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBox extends StatefulWidget {
  final bool backButton;
  final String title;
  final String searchHint;
  final Function(bool)? onFocusChange;
  final bool filtersActive;
  final VoidCallback? onFiltersPressed;
  final bool autoFocus;
  final AlignmentGeometry titleAlignment;
  final ValueChanged<String>? onSubmitted;
  final bool viewFilter;

  const SearchBox({
    super.key,
    required this.title,
    this.searchHint = 'Search',
    this.backButton = false,
    this.onFocusChange,
    this.autoFocus = false,
    this.onFiltersPressed,
    this.filtersActive = false,
    this.titleAlignment = Alignment.center,
    this.onSubmitted,
    this.viewFilter = true
  });

  @override
  State<SearchBox> createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();

  setText(String text) {
    controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
  final l18 = AppLocalizations.of(context)!;

  final controller = TextEditingController();
  final searchHint = l18.search;
    return Container(
      padding: const EdgeInsets.all(DBox.xlSpace),
      decoration: const BoxDecoration(
        color: Color(0xfff9da42),
        borderRadius: BorderRadius.all(Radius.circular(DBox.borderRadiusMd)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (widget.backButton)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              Align(
                alignment: widget.titleAlignment,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign:
                      widget.backButton ? TextAlign.center : TextAlign.start,
                ),
              ),
            ],
          ),
          const DBox.verticalSpaceLg(),
          Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: widget.onFocusChange,
                  child: TextField(
                    controller: controller,
                    autofocus: widget.autoFocus,
                    onSubmitted: widget.onSubmitted,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff8fafc),
                      hintText: searchHint,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
              ),
              const DBox.horizontalSpaceMd(),
              if(widget.viewFilter)
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xff020617),
                  padding: const EdgeInsets.all(DBox.lgSpace),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DBox.borderRadiusSm,
                    ),
                  ),
                ),
                icon: Icon(
                  widget.filtersActive
                      ? Icons.clear
                      : Icons.display_settings_outlined,
                  color: Colors.white,
                ),
                onPressed: widget.onFiltersPressed,
              ),
            ],
          )
        ],
      ),
    );
  }
}
