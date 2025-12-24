import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onSearch;

  const SearchBox({
    super.key,
    required this.hintText,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: hintText,
              fillColor: Color(0xfff8fafc),
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            ),
            onChanged: onSearch,
          ),
        ),
      ],
    );
  }
}
