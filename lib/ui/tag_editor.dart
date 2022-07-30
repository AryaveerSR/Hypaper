import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {
  const TagEditor({
    Key? key,
    required this.tags,
    required this.inputDecoration,
    required this.updateTags,
    required this.tagBuilder,
  }) : super(key: key);

  final List<String> tags;
  final InputDecoration inputDecoration;
  final ValueChanged<List<String>> updateTags;
  final Widget Function(BuildContext context, String tag) tagBuilder;

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
                .map((tag) => widget.tagBuilder(context, tag))
                .map((tag) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: tag,
                    ))
                .toList(),
          ),
        ),
        TextField(
          controller: tagController,
          minLines: 1,
          maxLines: null,
          decoration: widget.inputDecoration,
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
