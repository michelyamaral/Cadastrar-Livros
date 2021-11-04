import 'dart:io';
import 'package:cadastrar_livro/livro.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'livros.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE livros(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      autor TEXT,
      editora TEXT,
      lido TEXT
    )
    ''');
  }

  Future<List<Livro>> getLivros() async {
    Database db = await instance.database;
    var livros = await db.query('livros');
    List<Livro> livroList =
        livros.isNotEmpty ? livros.map((c) => Livro.fromMap(c)).toList() : [];
    return livroList;
  }

  Future<int> add(Livro livro) async {
    Database db = await instance.database;
    final id = await db.insert('livros', livro.toMap());
    return id;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('livros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Livro livro) async {
    Database db = await instance.database;
    return await db.update('livros', livro.toMap(),
        where: 'id = ?', whereArgs: [livro.id]);
  }
}
