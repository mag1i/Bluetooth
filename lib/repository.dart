import 'package:sqflite/sqflite.dart';

import 'admin.dart';
import 'cnx.dart';
import 'dntsts.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection= DatabaseConnection();
  }
  static Database? _database;
  Future<Database?>get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }
  Future<void> signUpAdmin(Admin admin) async {
    final db = await _databaseConnection.setDatabase();
    await db.insert('admin', admin.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Admin?> login(String email, String password) async {
    final db = await _databaseConnection.setDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'admin',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return Admin.fromMap(maps.first);
    }
    return null;
  }
  Future<Admin?> getAdmin(String email) async {
    final db = await _databaseConnection.setDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'admin',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Admin.fromMap(maps.first);
    }
    return null;
  }
  Future<List<Dentists>> getDentists() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('dentists');
    return List.generate(maps.length, (index) {
      return Dentists()
        ..id = maps[index]['id']
        ..name = maps[index]['name']
        ..specialization = maps[index]['specialization']
        ..email = maps[index]['email']
        ..phone = maps[index]['phone']
        ..adress = maps[index]['adress']
        ..Availability = maps[index]['Availability']
        ..desc = maps[index]['desc'];
    });
  }


  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
  readpatbydate(table, date) async {
    var connection = await database;
    //return await connection?.rawQuery("SELECT patients.* FROM patients INNER JOIN appointments ON patients.id = appointments.idpt WHERE appointments.date = '$date'");
    return await connection?.rawQuery(
      'SELECT patients.* FROM patients '
          'INNER JOIN appointments ON patients.id = appointments.idpt '
          'WHERE appointments.date = ?',
      ['$date'],
    );

  }
  readDatapt(date) async {
    var connection = await database;
    String query = '''
    SELECT patients.*
    FROM patients
    INNER JOIN (
      SELECT idpt, MAX(date) AS last_date
      FROM appointments
      GROUP BY idpt
    ) AS last_appointments
    ON patients.id = last_appointments.idpt
    WHERE last_appointments.last_date = ?
  ''';
    return await connection?.rawQuery(query, [date]);
  }
  readDatabetween(startDate, endDate) async {
    var connection = await database;
    String query = '''
    SELECT patients.*
    FROM patients
    INNER JOIN (
      SELECT idpt, MAX(date) AS last_date
      FROM appointments
      GROUP BY idpt
    ) AS last_appointments
    ON patients.id = last_appointments.idpt
    WHERE last_appointments.last_date BETWEEN ? AND ?
  ''';
    return await connection?.rawQuery(query, [startDate, endDate]);
  }
  getPatientsWithLastAppointment(table, date) async {
    var connection = await database;
    return await connection?.rawQuery(
      'SELECT patients.* FROM patients '
          'INNER JOIN (SELECT idpt, MAX(date) AS last_appointment '
          'FROM appointments GROUP BY idpt) AS latest_appointments '
          'ON patients.id = latest_appointments.idpt '
          'WHERE latest_appointments.last_appointment = ? COLLATE NOCASE',
      [date],
    );
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'idpt=?', whereArgs: [itemId]);
  }
  readDataBystat(table, labelId) async {
    var connection = await database;
    return await connection?.query(table, where: 'statu=?', whereArgs: [labelId]);
  }
  readcatsbydr(table, labelId) async {
    var connection = await database;
    return await connection?.query(table, where: 'iddr=?', whereArgs: [labelId]);
  }
  readcatsbyadopt(table, labelId) async {
    var connection = await database;
    return await connection?.query(table, where: 'isadopt=?', whereArgs: [labelId]);
  }
  readcatsbyboth( city, isadopt) async {
    var connection = await database;
    return await connection?.rawQuery("SELECT * FROM cats WHERE city='$city' AND isadopt= $isadopt");
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  Future<int> deletePatient(int id) async {
    final db = await database;
    final appointmentsDeleted = await db!.delete('appointments', where: 'idpt = ?', whereArgs: [id]);
    final patientsDeleted = await db.delete('patients', where: 'id = ?', whereArgs: [id]);

    return patientsDeleted;
  }
  updateOneData(table, field, newValue, id) async {
    var connection = await database;
    var dataToUpdate = <String, Object?>{field: newValue}; // Specify the type of the dataToUpdate map
    return await connection?.update(table, dataToUpdate, where: 'id = ?', whereArgs: [id]);
  }

  updatepaymnt( id, pay) async {
    var connection = await database;
    return await connection?.rawUpdate("UPDATE appointments SET payment= $pay WHERE id=$id");

  }

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
  deleteevent(table, itemnane) async {
    var connection = await database;
    return await connection?.rawDelete("delete from Events where nameevent=$itemnane");
  }
  deleteEventById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where idevent=$itemId");
  }
  deletectgrById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where idlabel=$itemId");
  }



  Future<int> readclrById( itemId) async {
    var connection = await database;
    final mp=  await connection?.rawQuery("select colorlabel from Label where idlabel=$itemId");
    int h= mp!.first.values.first as int;
  //  var hh= mp!.first.values.toList() as int;
   // int hhh= hh[0];
    return  h;}
  clr( itemId) async {
    var connection = await database;
    return await connection?.rawQuery("select colorlabel from Label where idlabel=$itemId");
   }


}