import 'package:contactapp/utils/database/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> getDatabase() async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  // InsertData
  insertData(table, data) async {
    var connection = await getDatabase();
    return await connection?.insert(table, data);
  }

  // Read All records
  readData(table) async {
    var connection = await getDatabase();
    return await connection?.query(table);
  }

  // Read a Single Record By ID
  readDataById(table, itemId) async {
    var connection = await getDatabase();
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  // Update User
  updateData(table, data) async {
    var connection = await getDatabase();
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  // Delete User
  deleteDataById(table, itemId) async {
    var connection = await getDatabase();
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
