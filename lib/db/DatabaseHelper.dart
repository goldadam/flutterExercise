import 'package:sqflite/sqflite.dart';

// 데이터베이스 작업 함수 등록.. 개발자 일종의 util...
class DatabaseHelper {
  // 이 클래스의 객체가 여러개 생성될 필요가 없어서,, Singleton으로 한번만 생성되도록.
  // DAO 클래스와 비슷한 성격...
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    //DB 이용 객체 준비
    return await openDatabase(
      'my_db.db', // db file name
      version: 1,
      // optional, 앱 인스톨 후 한번만 호출.. 주로 table create..
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE TB_MYINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, EMAIL TEXT, PHONE TEXT, PHOTO TEXT)'
        );
      }
    );
  }

  Future<int> insertMyInfo(Map<String, dynamic> data) async {
    final db = await database;
    await db.delete('TB_MYINFO');
    return await db.insert('TB_MYINFO', data);
  }

  Future<List<Map<String, dynamic>>> getMyInfo() async {
    final db = await database;
    return await db.query('TB_MYINFO');
  }
}
