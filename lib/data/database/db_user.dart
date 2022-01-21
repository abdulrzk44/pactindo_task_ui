import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import 'database.queries/user_query.dart';

class CrudUser {
  //membuat method singleton
  static CrudUser _crudUser = CrudUser._singleton();

  factory CrudUser() {
    return _crudUser;
  }

  CrudUser._singleton();

  //baris terakhir singleton

  final table = UserQuery.CREATE_TABLE; // membuat daftar table yang akan dibuat

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'user_data.db'),
        onCreate: (db, version) async {
            await db.execute(table).then((value) {
              print("berashil ");
            }).catchError((err) {
              print("errornya ${err.toString()}");
            });
          print('Table Created');
        }, version: 1);
  }

  Future<bool> checkDB(){
    return sqlite.databaseExists('user_data.db');
  }

  insert(Map<String, Object> data) {
    openDB().then((db) {
      Future <int> insert(Map<String, Object> data) async{
        int result = 1;
        await openDB().then((db) {
          db.insert(UserQuery.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
          result = 0;
        }).catchError((err) {
          result = 1;
          print("error $err");
        });
        return result;
      }
    });
  }

  update(Map<String, Object> data) {
    openDB().then((db) {
      db.update(UserQuery.TABLE_NAME, data, where: "id = 1", conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
  }

  Future<List> getData() async {
    final db = await openDB();
    var result = await db.query(UserQuery.TABLE_NAME);
    return result.toList();
  }
}

