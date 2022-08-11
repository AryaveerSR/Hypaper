import 'package:flutter/material.dart';

import 'tag_chip.dart';

class TagEditor extends StatefulWidget {
  final List<String> tags;
  final ValueChanged<List<String>> updateTags;
  final VoidCallback validate;

  const TagEditor(
      {Key? key,
      required this.tags,
      required this.updateTags,
      required this.validate})
      : super(key: key);

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
        Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus && tagController.text.isNotEmpty) {
              widget.updateTags(
                  widget.tags..add(tagController.text.replaceAll(',', '')));
              tagController.text = "";
            }
          },
          child: TextFormField(
            controller: tagController,
            minLines: 1,
            validator: (val) => val == null || val.isEmpty
                ? null
                : ','.allMatches(val).length < val.length
                    ? null
                    : 'Invalid tag',
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                errorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error)),
                hintText: 'New Tag'),
            onChanged: (newValue) {
              if (newValue.endsWith(",") &&
                  (newValue.replaceAll(',', '')).isNotEmpty) {
                widget.updateTags(widget.tags
                  ..add(newValue
                      .substring(0, newValue.length - 1)
                      .replaceAll(',', '')));
                tagController.text = "";
              }
              widget.validate();
            },
          ),
        ),
      ],
    );
  }
}
