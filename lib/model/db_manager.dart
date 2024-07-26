import 'package:monk_food/model/menu_model.dart';
import 'package:monk_food/model/store_model.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  final String tableCustomers = 'customers';
  final String tableDrivers = 'drivers';
  final String tableStore = 'store';
  final String tableMenu = 'menu';
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
            password TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableDrivers (
            id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            phone TEXT,
            password TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableStore (
            id INTEGER PRIMARY KEY,
            name TEXT,
            image TEXT,
            category TEXT
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

        DataImporter.importStoreAndMenuData();
      },
      version: databaseVersion,
    );
  }

  Future<void> initDB() async {
    await database;
  }

  Future<List<Store>> getAllStores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableStore);
    return List.generate(maps.length, (i) {
      return Store.fromMap(maps[i]);
    });
  }

  Future<List<Menu>> getAllMenu() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableMenu);
    return List.generate(maps.length, (i) {
      return Menu.fromMap(maps[i]);
    });
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