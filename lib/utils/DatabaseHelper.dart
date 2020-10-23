import 'dart:io';
import 'package:TDM/models/databaseModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
// creating a singleton class
  DatabaseHelper._private();
  static final DatabaseHelper instance = DatabaseHelper._private();

  // by this , we can make only one instance of this class (singleton completed )

  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    var path = join(databaseDirectory.path, 'notes.db');
    return await openDatabase(path, version: 1, onCreate: _populateDatabase);
  }

  _populateDatabase(Database db, int version) async {
    return await db.execute('''
  CREATE TABLE ${DatabaseModel.tableName}(
    ${DatabaseModel.colId} INTEGER PRIMARY KEY AUTOINCREMENT ,
    ${DatabaseModel.colTitle} TEXT NOT NULL ,
    ${DatabaseModel.colDescription} TEXT,
    ${DatabaseModel.colPriority} INTEGER NOT NULL,
    ${DatabaseModel.colDate} TEXT,
    ${DatabaseModel.colDeadline} TEXT 
  )
  ''');
  }

  Future<int> insertNote(DatabaseModel noteModel) async {
    Database db = await database;
    Map<String, dynamic> note = noteModel.toMap();
    // int result = await db.rawInsert("INSERT INTO ${DatabaseModel.tableName} "
    //     "VALUES (${note[DatabaseModel.colTitle]} , ${note[DatabaseModel.colDescription]} , ${note[DatabaseModel.colPriority]})");
    // return result;

    int result = await db.insert(DatabaseModel.tableName, note);
    return result;
  }

  Future<List<DatabaseModel>> fetchData() async {
    Database db = await database;
    List<Map> note = await db.rawQuery(
        'SELECT * FROM ${DatabaseModel.tableName} ORDER BY ${DatabaseModel.colPriority} DESC ; ');
    if (note.length == 0) {
      return [];
    } else {
      var list = note.map((e) => DatabaseModel.fromMap(e)).toList();
      return list;
    }
  }

  Future<void> updateNote(DatabaseModel noteModel) async {
    Database db = await database;
    var result = await db.update(DatabaseModel.tableName, noteModel.toMap(),
        where: '${DatabaseModel.colId}=?', whereArgs: [noteModel.id]);

    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    var result = await db.delete(DatabaseModel.tableName,
        where: '${DatabaseModel.colId} = ?', whereArgs: [id]);
    return result;
  }
}
