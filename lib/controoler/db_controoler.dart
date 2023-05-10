import 'package:path/path.dart';
import 'package:reminder_app/model/db_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();
  late Database database;

  Future<void> initDb() async {
    String path1 = await getDatabasesPath();
    String path = join(path1, 'my1.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String q =
            "CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,dec TEXT,endTime TEXT,date TEXT)";
        db.execute(q);
      },
    );
  }

  Future<int> insert(
      {required String c,
      required String dec,
      required String e,
      required String d}) async {
    String q = "Insert into tasks(category,dec,endTime,date) values(?,?,?,?)";
    List k = [c, dec, e, d];
    int ind = await database.rawInsert(q, k);
    return ind;
  }

  Future<List<DbModel>?> selectAll({String? d}) async {
    String q = "SELECT * FROM tasks WHERE date = ?";
    List k1 = [d];
    List<Map>? data = await database.rawQuery(q, k1);
    print(data);

    List<DbModel>? k = data!.map((e) => DbModel.json(data: e)).toList();
    return k;
  }

  Future<int> DeleteData({required int id}) async {
    String q = "DELETE FROM tasks WHERE id = ?";
    List k = [id];

    int d = await database.rawDelete(q, k);
    return d;
  }
}
