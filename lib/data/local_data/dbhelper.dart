import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  //table columns

  static final String TABLE_NOTE = "notes";
  static final String COLUMN_SRN = "sr_no";
  static final String TEXT_TITLE = "title";
  static final String TEXT_DESP = "notes";

  Database? mydb;

  // dbopen else create
  Future<Database> getdb() async {
    mydb ??= await opendb();
    return mydb!;
    // if (mydb != null) {
    //   return mydb!;
    // } else {
    //   mydb = await opendb();
    //   return mydb!;
    // }
  }

  Future<Database> opendb() async {
    Directory myAppDir = await getApplicationDocumentsDirectory();

    String myPath = join(myAppDir.path, "note.db");
    return await openDatabase(myPath, onCreate: (db, version) {
      //create table heres
      db.execute(
          "CREATE TABLE $TABLE_NOTE($COLUMN_SRN INTEGER PRIMARY KEY AUTOINCREMENT, $TEXT_TITLE TEXT, $TEXT_DESP TEXT)");
    }, version: 3);
  }


  ///query
  Future<bool> addNotes({required String mTitle, required String mDesp}) async {
    var db = await getdb();
    int rowsEffected = await db.insert(TABLE_NOTE, {TEXT_TITLE: mTitle, TEXT_DESP: mDesp});
    return rowsEffected >0;
  }

  Future<List<Map<String, dynamic>>> getallNotes() async {
    try {
      var db = await getdb();
      List<Map<String, dynamic>> alltbdata = await db.query(TABLE_NOTE);
      return alltbdata;
    } catch (e) {
      print("Error getting notes: $e");
      return []; // Return an empty list on error
    }
}

    Future<bool> updateNotes({required String mTitle, required String mDes, required int srNo}) async {
      var db = await getdb();
     int rowsEffected = await db.update(TABLE_NOTE, {
        TEXT_TITLE : mTitle,
        TEXT_DESP : mDes,
      }, where: '$COLUMN_SRN = ?', whereArgs: [srNo]);
      return rowsEffected > 0;
    }

    Future<bool> deleteNotes ({required int sno}) async {
      var db = await getdb();

      int rowEffected = await db.delete(TABLE_NOTE, where: '$COLUMN_SRN = ?', whereArgs: ['$sno']);
      return rowEffected >0;
      
    }

  }
