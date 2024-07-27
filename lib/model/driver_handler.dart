import 'package:monk_food/model/db_manager.dart';
import 'package:monk_food/model/driver_model.dart';

class DriverHandler {
  final String tableDrivers = DBManager.instance.tableDrivers;

  Future<int> register(Map<String, dynamic> user) async {
    return await DBManager.instance.register(
      tableDrivers,
      user,
    );
  }

  Future<bool> isUsernameUnique(String username) async {
    return DBManager.instance.isUsernameUnique(
      tableDrivers,
      username,
    );
  }

  Future<bool> isEmailExisted(String email) async {
    return DBManager.instance.isEmailExisted(
      tableDrivers,
      email,
    );
  }

  Future<Driver?> login(String username, String password) async {
    final result = await DBManager.instance.login(tableDrivers, username, password);

    if (result.isNotEmpty) {
      return Driver.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Driver?> getDriverByEmail(String email) async {
    final result = await DBManager.instance.getUserByEmail(tableDrivers, email);

    if (result.isNotEmpty) {
      return Driver.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updatePassword(String email, String newPassword) async {
    return await DBManager.instance.updatePassword(
      tableDrivers,
      email,
      newPassword,
    );
  }
}
