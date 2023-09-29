import 'package:crud/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCrud {
  static DatabaseCrud? _instance;
  static Database? _database;

  DatabaseCrud._internal() {
    _instance = this;
  }

  factory DatabaseCrud() => _instance ?? DatabaseCrud._internal();

  static const String _tblUser = 'user';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/crud_sqflite.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblUser(
            idUser INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            noHp TEXT,
            tanggalLahir TEXT,
            jenisKelamin TEXT
          )''');
    }, version: 1);

    return db;
  }

  // Get Database
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  // Insert Data
  Future<void> insertUser(User user) async {
    final db = await database;
    await db!.insert(_tblUser, user.toJson());
  }

  // Get Data
  Future<List<User>> getUser() async {
    final db = await database;
    List<Map<String, dynamic>> data = await db!.query(_tblUser);

    return data.map((res) => User.fromJson(res)).toList();
  }

  // Get Data By Id
  Future<Map> getUserById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> data = await db!.query(
      _tblUser,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (data.isNotEmpty) {
      return data.first;
    } else {
      return {};
    }
  }

  // Update Data
  Future<void> editUser(User id) async {
    final db = await database;

    await db!.update(
      _tblUser,
      id.toJson(),
      where: 'idUser = ?',
      whereArgs: [id],
    );
  }


  // Remove Data
  Future<void> removeUser(int id) async {
    final db = await database;

    await db!.delete(
      _tblUser,
      where: 'idUser = ?',
      whereArgs: [id],
    );
  }
}
