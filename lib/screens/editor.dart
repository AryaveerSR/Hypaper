import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/notes/notes.dart';
import '../ui/app_bar/app_bar.dart';

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
  String titleContent = "";
  String textContent = "";
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  bool hasInit = false;

  void _editNote(Note updatedNote) async {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        content: Text("Note Updated",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            textColor: Theme.of(context).primaryColor,
            label: "OK",
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar())));
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
      setState(() => hasInit = true);
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() => textContent = contentController.text);
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: widget.isNew ? "New Note" : "Edit Note",
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _editNote(Note(
              id: widget.note.id,
              title: titleController.text,
              content: contentController.text,
              dateCreated: widget.note.dateCreated,
              dateEdited: DateTime.now())),
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
                onSubmitted: (updatedContent) =>
                    setState(() => titleContent = updatedContent),
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
                onSubmitted: (updatedContent) =>
                    setState(() => textContent = updatedContent),
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
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
