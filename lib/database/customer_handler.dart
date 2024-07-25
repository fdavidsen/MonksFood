import 'package:monks_food/model/customer_model.dart';
import 'package:monks_food/model/db_manager.dart';
import 'package:sqflite/sqflite.dart';

class CustomerHandler {
  final String tableCustomers = DBManager.instance.tableCustomers;

  Future<int> registerCustomer(Map<String, dynamic> user) async {
    final db = await DBManager.instance.database;
    return await db.insert(
      tableCustomers,
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> isUsernameUnique(String username) async {
    final db = await DBManager.instance.database;
    final result = await db.query(
      tableCustomers,
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isEmpty;
  }

  Future<bool> isEmailExisted(String email) async {
    final db = await DBManager.instance.database;
    final result = await db.query(
      tableCustomers,
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  Future<Customer?> login(String username, String password) async {
    final db = await DBManager.instance.database;

    final result = await db.query(
      tableCustomers,
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCustomerByEmail(String email) async {
    final db = await DBManager.instance.database;

    final result = await db.query(
      tableCustomers,
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> updatePassword(String email, String newPassword) async {
    final db = await DBManager.instance.database;
    return await db.update(
      tableCustomers,
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
