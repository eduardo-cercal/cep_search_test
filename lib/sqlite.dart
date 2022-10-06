import 'dart:io';

import 'package:cep_search_test/helpers/constants.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'model/cep_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "cepdatabase.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''create table $cepTable(
        $id integer primary key autoincrement,
        $zipcode text,
        $district text,
        $cityLatitude real,
        $cityLongitude real,
        $markerLatitude real,
        $markerLongitude real,
        $dateTimeIns int
        );''');
  }

  Future<List<CepModel>> getTodaySearch() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> queryResult =
        await db.query(cepTable, where: "$dateTimeIns = ?", whereArgs: [
      DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
          .millisecondsSinceEpoch
    ]);

    return queryResult.isNotEmpty
        ? queryResult.map((json) => CepModel.fromJson(json)).toList()
        : [];
  }

  Future<void> insert(CepModel cepModel) async {
    Database db = await instance.database;
    await db.insert(cepTable, cepModel.toMap());
  }
}
