import 'package:final_exam/data/models/expanse_model.dart';
import 'package:final_exam/data/models/income_model.dart';
import 'package:sqflite/sqflite.dart';

class IncomeDatabaseService {
  String tableName = "incomes";
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

  Future<List<IncomeModel>> getExpanses() async {
    try {
      final db = await database;

      final expanses = await db.query(tableName);
      print(expanses);
      List<IncomeModel> loadedIncomes = [];
      expanses.forEach((element) {
        loadedIncomes.add(IncomeModel.fromMap(element));
      });
      return loadedIncomes;
    } on DatabaseException {
      throw "Daromadlarni yuklashda muammo mavjud";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addIncome(IncomeModel income) async {
    try {
      final db = await database;
      db.insert(tableName, income.toMap());
    } on DatabaseException {
      throw "Daromadlarni qo'shishda xatolik bo'ldi";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateIncome(ExpanseModel expanse) async {
    try {
      final db = await database;
      db.update(tableName, expanse.toMap(), where: "id = ${expanse.id}");
    } on DatabaseException {
      throw "Daromadlarni yangilashda xatolik boldi";
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteIncome(int id) async {
    try {
      final db = await database;

      final num = await db.delete(tableName, where: "id=$id");
      print("success $num");
    } on DatabaseException {
      throw "Daromadlarni ochirishda muammo mavjud";
    } catch (error) {
      rethrow;
    }
  }
}
