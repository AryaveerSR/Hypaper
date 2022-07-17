import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'note.model.dart';
export 'note.model.dart';

class NotesRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("notes");

  Future<int> addNote(Note note) async {
    return await _store.add(_database, note.toMap());
  }

  Future updateNote(Note note) async =>
      await _store.record(note.id).update(_database, note.toMap());

  Future deleteNote(int noteID) async =>
      await _store.record(noteID).delete(_database);

  Future<List<Note>> getAllNotes() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Note.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
