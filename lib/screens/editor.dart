import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/notes.dart';
import '../ui/app_bar.dart';
import '../ui/notify.dart';
import '../ui/tag_editor.dart';

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
  final _formKey = GlobalKey<FormState>();
  List<String> tags = [];

  void _editNote(Note updatedNote) async {
    Navigator.of(context).pop(updatedNote);
    notifySnack(context, type: NotifyType.updated);
    await _notesRepository.updateNote(updatedNote);
  }

  @override
  void initState() {
    super.initState();
    contentController.text = widget.note.content;
    titleController.text = widget.note.title;
    for (String tag in (widget.note.tags ?? [])) {
      tags.add(tag);
    }
    setState(() {});
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(
            title: widget.isNew ? "New Note" : "Edit Note", isSelected: false),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _editNote(widget.note.copyWith(
                  title: titleController.text,
                  content: contentController.text,
                  dateEdited: DateTime.now(),
                  tags: tags));
            }
          },
          child: const Icon(Icons.save),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  onChanged: (_) => _formKey.currentState!.validate(),
                  validator: (val) => (val == null || val.isEmpty)
                      ? 'Title is required'
                      : (val.length > 64)
                          ? 'Title must be less than 64 characters'
                          : null,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: const OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      )),
                ),
                const SizedBox(height: 16),
                TagEditor(
                    updateTags: (newValue) => setState(() => tags = newValue),
                    tags: tags,
                    validate: () => _formKey.currentState!.validate()),
                const SizedBox(height: 24),
                TextFormField(
                  controller: contentController,
                  minLines: 2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Content",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
