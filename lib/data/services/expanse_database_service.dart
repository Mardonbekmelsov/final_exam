import 'package:final_exam/data/models/expanse_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpanseService {
  String tableName = "expanse";
  Database? _database;
  Future<void> createDatabase(Database db) async {
    await db.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER PRIMARY KEY,
      value TEXT,
      category TEXT,
      time TEXT,
      comment TEXT
    )""");
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    final db = await openDatabase(
      "$path/locale.db",
      version: 1,
      onOpen: createDatabase,
    );
    return db;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<List<ExpanseModel>> getExpanses() async {
    try {
      final db = await database;

      final expanses = await db.query(tableName);
      print(expanses);
      List<ExpanseModel> loadedExpanses = [];
      expanses.forEach((element) {
        loadedExpanses.add(ExpanseModel.fromMap(element));
      });
      return loadedExpanses;
    } on DatabaseException {
      throw "Xarajatlarni yuklashda muammo mavjud";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addExpanse(ExpanseModel expanse) async {
    try {
      final db = await database;
      db.insert(tableName, expanse.toMap());
    } on DatabaseException {
      throw "Xarajatni qo'shishda xatolik bo'ldi";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateExpanse(int id, ExpanseModel expanse) async {
    try {
      final db = await database;
      db.update(tableName, expanse.toMap(), where: "id = ${expanse.id}");
    } on DatabaseException {
      throw "Xarajatni yangilashda xatolik boldi";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteExpanse(int id) async {
    try {
      final db = await database;

      final num = await db.delete(tableName, where: "id=$id");
      print("success $num");
    } on DatabaseException {
      throw "Xarajatlarni ochirishda muammo mavjud";
    } catch (error) {
      rethrow;
    }
  }
}
