import 'package:flutter/material.dart';

class TagEditor extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: tags.join(delimiters[0])),
      minLines: 1,
      maxLines: null,
      decoration: inputDecoration,
      onChanged: (newValue) {
        final newTags = newValue.split(delimiters[0]);
        if (newTags.length > tags.length) {
          newTags.removeAt(newTags.length - 1);
        }
        updateTags(newTags);
      },
    );
  }
}
