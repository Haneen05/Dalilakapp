import 'package:daleelakappx/models/category.dart';
import 'package:daleelakappx/models/sub_category.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:daleelakappx/api.dart' as api;

enum SortOrder {
  ascending,
  descending,
}

class SearchFiltersWidget extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onApplyFilters;
  final VoidCallback onClearFilters;
  final SortOrder? initialSortOrder;
  final String? initialLocation;
  final String? initialCategory;
  final String? initialSubCategory;

  const SearchFiltersWidget({
    super.key,
    required this.onApplyFilters,
    required this.onClearFilters,
    this.initialSortOrder,
    this.initialLocation,
    this.initialCategory,
    this.initialSubCategory,
  });

  @override
  State<SearchFiltersWidget> createState() => _SearchFiltersWidgetState();
}

class _SearchFiltersWidgetState extends State<SearchFiltersWidget> {
  late SortOrder? sortOrder;
  late String? selectedLocation;
  late String? selectedCategory;
  late String? selectedSubCategory;
  List<Category> categories = [];
  List<Subcategory> subcategories = [];

  @override
  void initState() {
    super.initState();
    sortOrder = widget.initialSortOrder;
    selectedLocation = widget.initialLocation;
    selectedCategory = widget.initialCategory;
    selectedSubCategory = widget.initialSubCategory;
    _fetchCategories();
  }

  void _fetchCategories() async {
    var fetchedCategories = await api.categories.findMany();
    setState(() {
      categories = fetchedCategories;
    });
  }

  void _fetchSubcategories(String categoryId) async {
    var fetchedSubcategories =
        await api.subcategories.findByCategory(categoryId);
    setState(() {
      subcategories = fetchedSubcategories;
      if (subcategories.isNotEmpty) {
        selectedSubCategory = subcategories.first.id;
      } else {
        selectedSubCategory = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l18 = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(DBox.xlSpace),
            child: Column(
              children: [
                Row(
                  children: [
                    const ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Color(0xff64748b),
                        BlendMode.srcATop,
                      ),
                      child: DIcons.sortArrows,
                    ),
                    const DBox.horizontalSpaceLg(),
                    Text(
                      l18.sortBy,
                      style: const TextStyle(
                        fontSize: DBox.fontLg,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const DBox.verticalSpaceLg(),
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        label: Text(l18.ascending),
                        icon: const Icon(Icons.sort_by_alpha),
                        onPressed: () {
                          setState(() => sortOrder = SortOrder.ascending);
                        },
                        filled: sortOrder == SortOrder.ascending,
                      ),
                    ),
                    const DBox.horizontalSpaceSm(),
                    Expanded(
                      child: _buildButton(
                        label: Text(l18.descending),
                        icon: const Icon(Icons.sort_by_alpha),
                        onPressed: () {
                          setState(() => sortOrder = SortOrder.descending);
                        },
                        filled: sortOrder == SortOrder.descending,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const DBox.verticalSpaceLg(),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(DBox.xlSpace),
            child: DColumn(
              mainAxisSpacing: DBox.xlSpace,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: l18.location,
                  ),
                  onChanged: (value) {
                    setState(() => selectedLocation = value);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id, // Use category ID as the value
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      selectedSubCategory = null;
                      _fetchSubcategories(value!);
                    });
                  },
                  hint: Text(l18.category),
                ),
                DropdownButtonFormField<String>(
                  value: selectedSubCategory,
                  items: subcategories.map((subcategory) {
                    return DropdownMenuItem<String>(
                      value: subcategory.id, // Use subcategory ID as the value
                      child: Text(subcategory.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedSubCategory = value);
                  },
                  hint: Text(l18.subCategory),
                  disabledHint: Text('SelectACategoryFirst'),
                  validator: (value) {
                    if (selectedCategory == null) {
                      return 'SelectACategoryFirst';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          selectedLocation = null;
                          selectedCategory = null;
                          selectedSubCategory = null;
                          sortOrder = null;
                        });
                        widget.onClearFilters();
                      },
                      child: Text(l18.clear),
                    ),
                    const DBox.horizontalSpaceMd(),
                    Expanded(
                      child: FilledButton.icon(
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          widget.onApplyFilters({
                            'address': selectedLocation,
                            'category': selectedCategory,
                            'subCategory': selectedSubCategory,
                            'sortOrder': sortOrder,
                          });
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        label: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            children: [
                              const Icon(Icons.filter_alt_outlined),
                              const DBox.horizontalSpaceSm(),
                              Text(l18.applyFilters),
                            ],
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
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
    return items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  Widget _buildButton({
    required Widget icon,
    required Widget label,
    required VoidCallback onPressed,
    required bool filled,
  }) {
    if (filled) {
      return FilledButton.icon(
        icon: icon,
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        label: label,
        onPressed: onPressed,
      );
    } else {
      return OutlinedButton.icon(
        icon: icon,
        label: label,
        onPressed: onPressed,
      );
    }
  }
}
