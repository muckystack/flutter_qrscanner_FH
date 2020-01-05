import 'dart:io';

import 'package:flutter_qrscanner_fh/src/models/scann_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  // Propiedad privada
  static Database _database;
  // Constructor privado
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    // En caso de que haya una instancia de base de datos
    if(database != null) return _database;

    // En caso de que no haya una instancia de base de datos la creamos
    _database = await initDB();
    return _database;

  }

  initDB() async {
    // Obtiene el path de donde se encuantra la base de datos, esto es solo donde se puese escribir
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Obtenemos el path completo incluyendo el nombre del archivo
    final path = join(documentsDirectory.path, 'ScansDB.db');

    // Comandos para crear la base de datos
    
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );
  }

  // Crear registros de base de datos
  nuevoScanRaw(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES (${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"
    );

    return res;

  }

  // La forma que se esta utilizando para insertar
  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }


}