import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {
  const TagEditor({
    Key? key,
    required this.tags,
    required this.delimiters,
    required this.inputDecoration,
    required this.updateTags,
    required this.tagBuilder,
  }) : super(key: key);

  final List<String> tags;
  final List<String> delimiters;
  final InputDecoration inputDecoration;
  final ValueChanged<List<String>> updateTags;
  final Widget Function(BuildContext context, int index) tagBuilder;

  @override
  State<TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends State<TagEditor> {
  bool hasInit = false;
  final tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!hasInit) {
      tagController.text = widget.tags.join(widget.delimiters[0]);
      setState(() {
        hasInit = true;
      });
    }
    return TextField(
      controller: tagController,
      minLines: 1,
      maxLines: null,
      decoration: widget.inputDecoration,
      onChanged: (newValue) {
        final newTags = newValue.split(widget.delimiters[0]);
        widget.updateTags(newTags);
      },
    );
  }
}
