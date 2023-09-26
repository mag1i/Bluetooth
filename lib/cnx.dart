import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseConnection{
  Future<Database>setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'uUdtst.db');
    var database =
    await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }


  Future<void>_createDatabase(Database database, int version) async {
    String sql=
        "CREATE TABLE patients(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT,gender TEXT, birth TEXT, address TEXT , insurance TEXT, email TEXT , phone TEXT);";
    await database.execute(sql);
    String sql2=
        "CREATE TABLE admin(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT, email TEXT, password TEXT );";
    await database.execute(sql2);


    String sql4="CREATE TABLE dentists (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, specialization TEXT, email TEXT, phone TEXT, image TEXT ,  adress Text, Availability TEXT, desc TEXT );";
    await database.execute(sql4);


    String sql3="CREATE TABLE appointments (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT, time TEXT, cas TEXT, statu TEXT, treatment Text, note TEXT,  scanner1 TEXT, scanner2 TEXT, payment double, idpt INTEGER, iddr INTEGER, FOREIGN KEY (idpt) REFERENCES patients (id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (iddr) REFERENCES dentists (id) ON DELETE CASCADE ON UPDATE CASCADE );";
    await database.execute(sql3);
    //ON DELETE NO ACTION ON UPDATE NO ACTION
  }
}