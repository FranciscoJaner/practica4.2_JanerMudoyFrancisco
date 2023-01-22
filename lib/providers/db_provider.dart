import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  // Classe que empleam per crear la base de dades i realitzar diferents operacions.
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  // Metode amb el cual cream i inicialitzam la nostra base de dades.
  Future<Database> initDB() async {
    // Obtenir el path per avon cream la nostra base de dades
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');

    // Creació de la nostra base de dades.
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY, 
          tipus TEXT, 
          valor TEXT
        )
      ''');
      },
    );
  }

  // Metodoe a partir de tres variables asignam al valor amb un insertRaw.
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
        INSERT INTO Scans(id,tipus,valor)
        VALUES ($id,$tipus,$valor)
      ''');
    return res;
  }

  // Metode que gracis a la clase model que hem fet anteriorment amb al toMap li pasam directe els valors que tenim.
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.insert('Scans', nouScan.toMap());
    return res;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

// Metode en el qual seleccionam un valor de la base de dades a partir del seu id.
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

// Metode en el qual seleccionam un valor de la base de dades a partir del seu tipus ja sigui geo o http.
  Future<List<ScanModel>> getScanByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

// Metode amb el qual actualizam el valor de la nostre base de dades a partir del id.
  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.update('Scans', nouScan.toMap(),
        where: 'id = ?', whereArgs: [nouScan.id]);

    return res;
  }

// Metode amb el qual borram de la base de dades un valor a partir del seu id.
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

// Metode amb el qual borram de la base de dades tots els valors.
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''DELETE FROM Scans''');

    return res;
  }
}
