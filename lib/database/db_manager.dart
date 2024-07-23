import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  final String tableCustomers = 'customers';
  final String tableDrivers = 'drivers';
  final String tableOTP = 'otp';
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
          CREATE TABLE $tableCustomers
            (id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            phone TEXT,
            password TEXT);
        ''');

        await db.execute('''
          CREATE TABLE $tableDrivers
            (id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            phone TEXT,
            password TEXT);
        ''');

        await db.execute('''
          CREATE TABLE $tableOTP
            (id INTEGER PRIMARY KEY,
            email TEXT,
            otp TEXT,
            createdAt TEXT);
        ''');
      },
      version: databaseVersion,
    );
  }
}
