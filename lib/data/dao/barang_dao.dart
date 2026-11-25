
import 'package:flutter_application_1/data/database/db_helper.dart';
import 'package:flutter_application_1/model/barang.dart';

class BarangDao {
  final DbHelper _dbHelper;

  BarangDao(this._dbHelper);

  static const _nameTable = DbHelper.tableName;

  // CREATE
  Future<int> insert(Barang barang) async {
    final db = await _dbHelper.database;

    return db.insert(
      _nameTable,
      barang.toMap(),
    );
  }

  // READ
  Future<List<Barang>> getAllBarang() async {
    final db = await _dbHelper.database;

    final getData = await db.query(
      _nameTable,
      orderBy: 'id DESC',
    );

    return getData.map(Barang.fromMap).toList();
  }

  // UPDATE
  Future<int> update(Barang barang) async {
    final db = await _dbHelper.database;

    return db.update(
      _nameTable,
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }

  // DELETE
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;

    return db.delete(
      _nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
