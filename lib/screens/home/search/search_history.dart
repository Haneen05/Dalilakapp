import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../widgets.dart';

class SearchHistoryWidget extends StatefulWidget {
  final Function(String text) onItemClick;

  const SearchHistoryWidget({super.key, required this.onItemClick});

  @override
  State<SearchHistoryWidget> createState() => SearchHistoryWidgetState();
}

class SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  List<String> _previousSearch = [];
  bool _loading = false;

  fetchPreviousSearch() async {
    try {
      setState(() => _loading = true);

      final sharedPrefs = await SharedPreferences.getInstance();
      final list = sharedPrefs.getStringList("previous_search") ?? [];
      setState(() => _previousSearch = list);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchPreviousSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _loading,
      child: Column(
        children: ListTile.divideTiles(
            context: context,
            color: const Color(0xffe2e8f0),
            tiles: _previousSearch.map((item) {
              return InkWell(
                onTap: () => widget.onItemClick(item),
                child: DRow(
                  mainAxisSpacing: DBox.mdSpace,
                  children: [
                    const Icon(
                      Icons.history,
                      color: Color(0xff64748b),
                    ),
                    Text(item),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: const Color(0xff64748b),
                      onPressed: () {
                        removeItem(item);
                      },
                    ),
                  ],
                ),
              );
            })).toList(),
      ),
    );
  }

  void removeItem(String item) async {
    try {
      setState(() => _loading = true);

      final sharedPrefs = await SharedPreferences.getInstance();
      final newList = _previousSearch.where((prev) => prev != item).toList();
      await sharedPrefs.setStringList("previous_search", newList);
      setState(() => _previousSearch = newList);
    } finally {
      setState(() => _loading = false);
    }
  }

  void addItem(String item) async {
    try {
      setState(() => _loading = true);

      final sharedPrefs = await SharedPreferences.getInstance();
      final newList = [
        item,
        ..._previousSearch
            .where((prev) => prev != item)
            .toList()
            .sublist(0, 9.clamp(0, _previousSearch.length))
      ];
      await sharedPrefs.setStringList("previous_search", newList);
      setState(() => _previousSearch = newList);
    } finally {
      setState(() => _loading = false);
    }
  }
}
