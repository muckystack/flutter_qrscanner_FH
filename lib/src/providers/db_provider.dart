import 'package:sqflite/sqflite.dart';


class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future get database async {

    // En caso de que haya una instancia de base de datos
    if(database != null) return _database;

    // En caso de que no haya una instancia de base de datos la creamos
    _database = await initDB();

  }

  initDB() async {
    
  }

}