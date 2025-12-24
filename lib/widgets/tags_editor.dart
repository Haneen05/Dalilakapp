import 'package:daleelakappx/widgets/column.dart';
import 'package:flutter/material.dart';

class TagsEditor extends StatefulWidget {
  final void Function(List<String> tags)? onChanged;

  const TagsEditor({
    super.key,
    this.onChanged,
  });

  @override
  State<TagsEditor> createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagsEditor> {
  final textController = TextEditingController();

  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffbdbdbd),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DColumn(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Wrap(
              spacing: 4.0,
              alignment: WrapAlignment.start,
              children: tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  onDeleted: () {
                    removeTag(tag);
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                );
              }).toList(),
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Add Keywords..',
            ),
            maxLines: 3,
            controller: textController,
            onChanged: (text) {
              if (text.characters.last == ' ') {
                final tag = text.substring(0, text.length - 1);
                text = textController.text = '';
                addTag(tag);
              }
            },
          ),
        ],
      ),
    );
  }

  void addTag(String tag) {
    setState(() => tags.add(tag));
    widget.onChanged?.call(tags);
  }

  void removeTag(String tag) {
    setState(() => tags.removeWhere((elem) => elem == tag));
    widget.onChanged?.call(tags);
  }
}
