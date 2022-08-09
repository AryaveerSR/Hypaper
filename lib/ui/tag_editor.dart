import 'package:flutter/material.dart';

import 'tag_chip.dart';

class TagEditor extends StatefulWidget {
  final List<String> tags;
  final ValueChanged<List<String>> updateTags;

  const TagEditor({
    Key? key,
    required this.tags,
    required this.updateTags,
  }) : super(key: key);

  @override
  State<TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends State<TagEditor> {
  final tagController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widget.tags
                .map((tag) => TagChip(
                    label: tag,
                    onRemove: () => widget.updateTags(
                        widget.tags.where((t) => t != tag).toList())))
                .map((tag) => Container(
                    margin: const EdgeInsets.only(right: 4), child: tag))
                .toList(),
          ),
        ),
        TextField(
          controller: tagController,
          minLines: 1,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), hintText: 'New Tag'),
          onChanged: (newValue) {
            if (newValue.endsWith(",") && newValue.length > 1) {
              widget.updateTags(
                  widget.tags..add(newValue.substring(0, newValue.length - 1)));
              tagController.text = "";
            }
          },
        ),
      ],
    );
  }
}
