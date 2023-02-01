import 'package:great_places/data/local/db_constants.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DatabaseSource {

  DatabaseSource? databaseSource;

  DatabaseSource();

  DatabaseSource.getInstance() {
    databaseSource ??= DatabaseSource();
  }

  Future<Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, DbConstants.dbName),
        onCreate: (database, version) {
      return database.execute(
          'CREATE TABLE user_places(id STRING PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await _database();
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await _database();
    return db.query(table);
  }

}
