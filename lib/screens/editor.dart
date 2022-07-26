import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_tag_editor/tag_editor.dart';

import '../services/notes/notes.dart';
import '../ui/app_bar.dart';
import '../ui/dialogs/notify.dart';

class EditorScreen extends StatefulWidget {
  final Note note;
  final bool isNew;
  const EditorScreen({Key? key, required this.note, required this.isNew})
      : super(key: key);
  @override
  State<EditorScreen> createState() => _EditorScreen();
}

class _EditorScreen extends State<EditorScreen> {
  final NotesRepository _notesRepository = GetIt.I.get();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> tags = [];
  bool hasInit = false;

  void _editNote(Note updatedNote) async {
    Navigator.of(context).pop();
    notifySnack(context, type: NotifyType.updated);
    await _notesRepository.updateNote(updatedNote);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasInit) {
      contentController.text = widget.note.content;
      titleController.text = widget.note.title;
      for (String tag in widget.note.tags!) {
        tags.add(tag);
      }
      setState(() => hasInit = true);
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: widget.isNew ? "New Note" : "Edit Note",
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _editNote(widget.note.copyWith(
              title: titleController.text,
              content: contentController.text,
              dateEdited: DateTime.now(),
              tags: tags)),
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.save),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: titleController,
                minLines: 1,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: contentController,
                minLines: 2,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TagEditor(
                  length: tags.length,
                  delimiters: const [',', ' '],
                  hasAddButton: true,
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Hint Text...',
                  ),
                  onTagChanged: (newValue) {
                    setState(() {
                      tags.add(newValue);
                    });
                  },
                  tagBuilder: (context, index) => Chip(
                        labelPadding: const EdgeInsets.only(left: 8.0),
                        label: Text(tags[index]),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 18,
                        ),
                        onDeleted: () {
                          setState(() {
                            tags.removeAt(index);
                          });
                        },
                      )),
              const SizedBox(height: 16.0),
              Text('Created ${Note.timeAgo(widget.note.dateCreated)}',
                  style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 8),
              Text('Last Edited ${Note.timeAgo(widget.note.dateEdited)}',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
