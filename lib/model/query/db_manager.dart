import 'package:monk_food/controller/data_importer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  final String tableCustomers = 'customers';
  final String tableDrivers = 'drivers';
  final String tableStore = 'store';
  final String tableMenu = 'menu';
  final String tableCart = 'cart';
  final String tableOrders = 'orders';
  final String databaseName = 'monks_food.db';
  final int databaseVersion = 1;

  static final DBManager instance = DBManager._init();
  static Database? _database;
  DBManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableCustomers (
            id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            phone TEXT,
            password TEXT,
            card_first_name TEXT,
            card_last_name TEXT,
            card_number TEXT,
            expiration_date TEXT,
            cvv TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableDrivers (
            id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            phone TEXT,
            password TEXT,
            profilePicture TEXT,
            driverLicenseFront TEXT,
            driverLicenseBack TEXT,
            certificate TEXT,
            bankId TEXT,
            bankFirstName TEXT,
            bankLastName TEXT,
            bankPhone TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableStore (
            id INTEGER PRIMARY KEY,
            name TEXT,
            image TEXT,
            category TEXT,
            latitude REAL,
            longitude REAL
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableMenu (
            id INTEGER PRIMARY KEY,
            store_id INTEGER,
            name TEXT,
            description TEXT,
            image TEXT,
            ice_hot TEXT,
            price REAL,
            tag TEXT,
            category TEXT,
            rating REAL,
            time TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableCart (
            id INTEGER PRIMARY KEY,
            user_id INTEGER,
            menu_id INTEGER,
            qty INTEGER,
            selected_ice_hot TEXT,
            is_active BOOLEAN
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableOrders (
            id TEXT PRIMARY KEY,
            user_id INTEGER,
            cart_item_ids TEXT,
            subtotal REAL,
            delivery_fee REAL,
            order_fee REAL,
            coupon_offer TEXT,
            offer_fee REAL,
            payment_method TEXT
          );
        ''');

        DataImporter.importStoreAndMenuData();
      },
      version: databaseVersion,
    );
  }

  Future<void> initDB() async {
    await database;
  }

  Future<int> register(String table, Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      table,
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, Object?>>> login(String table, String username, String password) async {
    final db = await database;
    final result = await db.query(
      table,
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result;
  }

  Future<bool> isUsernameUnique(String table, String username) async {
    final db = await database;
    final result = await db.query(
      table,
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isEmpty;
  }

  Future<bool> isEmailExisted(String table, String email) async {
    final db = await database;
    final result = await db.query(
      table,
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, Object?>>> getUserById(String table, int id) async {
    final db = await database;
    final result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<List<Map<String, Object?>>> getUserByEmail(String table, String email) async {
    final db = await database;
    final result = await db.query(
      table,
      where: 'email = ?',
      whereArgs: [email],
    );
    return result;
  }

  Future<int> updateForgetPassword(String table, String email, String newPassword) async {
    final db = await database;
    return await db.update(
      table,
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> insertMany(String table, List<Map<String, dynamic>> items) async {
    final db = await database;

    final columns = items.first.keys.map((item) => '"$item"').join(',');
    final values = List.generate(items.length, (index) {
      return '(${items[index].values.map((item) => '"$item"').join(',')})';
    }).join(',');

    final sql = 'INSERT OR REPLACE INTO $table ($columns) VALUES $values';
    await db.rawInsert(sql);
  }
}
