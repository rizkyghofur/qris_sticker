import 'package:sqflite/sqflite.dart';

class QrisStickerDbHelper {
  static final QrisStickerDbHelper _instance = QrisStickerDbHelper.internal();

  factory QrisStickerDbHelper() => _instance;

  static Database? _database;

  QrisStickerDbHelper.internal();

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final path = "${await getDatabasesPath()}qris_sticker.db";
    final db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE qris_sticker (
      id_qris INTEGER PRIMARY KEY AUTOINCREMENT,
      qris_name TEXT,
      keterangan TEXT,
      value TEXT,
      image BLOB
    )
  ''');
  }

  Future<int> saveQrisSticker(Map<String, dynamic> qrisSticker) async {
    final dbClient = await db;
    return await dbClient.insert('qris_sticker', qrisSticker);
  }

  Future<List<Map<String, dynamic>>> getAllQrisStickers() async {
    final dbClient = await db;
    final result = await dbClient.query('qris_sticker');
    return result.toList();
  }

  Future<Map<String, dynamic>> getQrisSticker(int id) async {
    final dbClient = await db;
    final result = await dbClient
        .query('qris_sticker', where: 'id_qris = ?', whereArgs: [id]);
    return result.first;
  }

  Future<int> deleteQrisSticker(int id) async {
    final dbClient = await db;
    return await dbClient
        .delete('qris_sticker', where: 'id_qris = ?', whereArgs: [id]);
  }

  Future<int> deleteAllQrisSticker() async {
    final dbClient = await db;
    return await dbClient.delete('qris_sticker');
  }

  Future<int> updateQrisSticker(Map<String, dynamic> qrisSticker) async {
    final dbClient = await db;
    return await dbClient.update('qris_sticker', qrisSticker,
        where: 'id_qris = ?', whereArgs: [qrisSticker['id_qris']]);
  }
}
