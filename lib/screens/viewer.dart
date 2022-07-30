import 'package:flutter/material.dart';
import '../services/notes.dart';
import '../ui/app_bar.dart';
import 'editor.dart';

class ViewerScreen extends StatefulWidget {
  final Function() updateNote;
  const ViewerScreen({Key? key, required this.updateNote}) : super(key: key);
  @override
  State<ViewerScreen> createState() => _ViewerScreen();
}

class _ViewerScreen extends State<ViewerScreen> {
  Note? note;
  void _editNote() async {
    Note updatedNote = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditorScreen(
                  note: note!,
                  isNew: false,
                )));
    setState(() => note = updatedNote);
  }

  _loadNote() async {
    final updatedNote = await widget.updateNote();
    setState(() => note = updatedNote);
  }

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "View Note",
        isSelected: false,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note!.title,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Theme.of(context).textTheme.headline5!.color,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 16.0),
                Text('Created ${Note.timeAgo(note!.dateCreated)}',
                    style: Theme.of(context).textTheme.caption),
                const SizedBox(height: 8),
                Text('Last Edited ${Note.timeAgo(note!.dateEdited)}',
                    style: Theme.of(context).textTheme.caption),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Tags: '),
                    ...note!.tags!.map((tag) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Chip(label: Text(tag))))
                  ],
                ),
                const SizedBox(height: 8),
                Divider(
                  color: Theme.of(context).textTheme.headline5!.color,
                  thickness: 1,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(note!.content, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
