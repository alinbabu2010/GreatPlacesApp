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
          'CREATE TABLE ${DbConstants.placesTable}(${MapKey.id} STRING PRIMARY KEY, ${MapKey.title} TEXT, ${MapKey.image} TEXT, ${MapKey.latitude} REAL,${MapKey.longitude} REAL, ${MapKey.address} TEXT)');
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
