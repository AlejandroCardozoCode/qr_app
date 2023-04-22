import 'dart:developer';
import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    // get directory of the app in the device
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // add to the path de file of the database
    final path = join(documentDirectory.path, "ScansDB.db");
    log(path);
    // create db on the directory
    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY  AUTOINCREMENT,
            type TEXT,
            value TEXT
          )
        """);
      },
    );
  }

  Future<int> insertToDB(ScanModel scan) async {
    final db = await database;
    final res = await db.insert("Scans", scan.toJson());
    return res;
  }

  Future<List<ScanModel>> getAllQRs() async {
    final db = await database;
    final res = await db.query("Scans");
    List<ScanModel> list = [];
    for (var scan in res) {
      ScanModel newScan = ScanModel.fromJson(scan);
      list.add(newScan);
    }
    return list.reversed.toList();
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete("Scans", where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete("Scans");
    return res;
  }
}
