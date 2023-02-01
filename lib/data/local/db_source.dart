import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class DatabaseSource {

  DatabaseSource? databaseSource;

  DatabaseSource();

  DatabaseSource.getInstance() {
    databaseSource ??= DatabaseSource();
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE user_places(id INTEGER PRIMARY KEY, name TEXT, image TEXT)');
    }, version: 1);
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
