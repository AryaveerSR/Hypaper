import 'package:flutter/material.dart';
import '../services/notes/notes.dart';
import '../ui/app_bar/app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);
  @override
  State<NoteScreen> createState() => _NoteScreen();
}

class _NoteScreen extends State<NoteScreen> {
  Note? note;

  void _editNote() => Navigator.of(context).pushNamed('/edit', arguments: note);

  @override
  Widget build(BuildContext context) {
    note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: const MyAppBar(
        title: "View Note",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editNote,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(note!.title,
                style: TextStyle(
                    fontSize: 24.0,
                    color: Theme.of(context).textTheme.headline5!.color,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 16.0),
            Text(note!.content, style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 16.0),
            Text('Created ${Note.timeAgo(note!.dateCreated)}',
                style: Theme.of(context).textTheme.caption),
            const SizedBox(height: 8),
            Text('Last Edited ${Note.timeAgo(note!.dateEdited)}',
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
