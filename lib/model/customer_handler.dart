import 'package:monk_food/model/db_manager.dart';
import 'package:monk_food/model/customer_model.dart';
import 'package:monk_food/model/menu_model.dart';
import 'package:monk_food/model/store_model.dart';

class CustomerHandler {
  final String tableCustomers = DBManager.instance.tableCustomers;
  final String tableStore = DBManager.instance.tableStore;
  final String tableMenu = DBManager.instance.tableMenu;

  Future<List<Store>> getAllStores() async {
    final db = await DBManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableStore);
    return List.generate(maps.length, (i) {
      return Store.fromMap(maps[i]);
    });
  }

  Future<List<Menu>> getAllMenu() async {
    final db = await DBManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableMenu);
    return List.generate(maps.length, (i) {
      return Menu.fromMap(maps[i]);
    });
  }

  Future<int> updateMyAccount(Customer customer) async {
    final db = await DBManager.instance.database;
    return await db.update(
      tableCustomers,
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> register(Map<String, dynamic> user) async {
    return await DBManager.instance.register(
      tableCustomers,
      user,
    );
  }

  Future<bool> isUsernameUnique(String username) async {
    return DBManager.instance.isUsernameUnique(
      tableCustomers,
      username,
    );
  }

  Future<bool> isEmailExisted(String email) async {
    return DBManager.instance.isEmailExisted(
      tableCustomers,
      email,
    );
  }

  Future<Customer?> login(String username, String password) async {
    final result = await DBManager.instance.login(tableCustomers, username, password);

    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Customer?> getCustomerByEmail(String email) async {
    final result = await DBManager.instance.getUserByEmail(tableCustomers, email);

    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updatePassword(String email, String newPassword) async {
    return await DBManager.instance.updatePassword(
      tableCustomers,
      email,
      newPassword,
    );
  }
}
