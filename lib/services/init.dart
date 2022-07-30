import 'package:flutter/foundation.dart';

import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'notes.dart';

class Init {
  static Future initialize() async {
    if (kDebugMode) print("[INIT] Starting Init...");
    await _initDatabase();
    await _registerRepositories();
    if (kDebugMode) print("[INIT] Finished Init.");
  }

  static Future _initDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "sembast.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }

  static _registerRepositories() {
    GetIt.I.registerLazySingleton<NotesRepository>(() => NotesRepository());
  }
}
