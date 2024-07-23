import 'package:database/planetas/planetas.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class Database {
  //Conexion y creacion de tablas
  //Corrutina
  static Future<sqlite.Database> Connect() async {
    String route = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(route, "solsystem.db"),
        version: 1, singleInstance: true, onCreate: (db, version) async{
          await create(db);
        });
  }

  static Future<void> create(sqlite.Database db) async {
    const String sql = """
      create table planeta(
        id integer primary key autoincrement not null,
        nombre text not null,
        AU real not null,
        radius real not null,
        createdAt timestamp not null default CURRENT_TIMESTAMP
      )
    """;
    await db.execute(sql);
  }
  static Future<List<Planetas>> getPlanets() async{
    //Open database
    List<Planetas>? planetario = [];
    final sqlite.Database db = await Database.Connect();
    final List<Map<String, dynamic>> query = await db.query("planeta");

    planetario = query.map((e){
      return Planetas.Mapa(e);
    }).toList();

    return planetario;
  }
  static Future<int> insert(List<Planetas> planets) async {
    final sqlite.Database db = await Database.Connect();
    int value = 0;
    for(Planetas planeta in planets){
      value = await db.insert("planeta", planeta.toMap(), conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
    }
    db.close();
    return value;
  }
  static Future<void> delete(int id) async{
    final sqlite.Database db = await Database.Connect();
    await db.delete("planeta", where: "id = ?", whereArgs: [id],);

  }
}
