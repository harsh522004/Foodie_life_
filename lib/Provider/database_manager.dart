import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/Meals.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  static Database? _database;

  DatabaseManager._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipe_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_recipes (
        id INTEGER PRIMARY KEY,
        recipeId TEXT NOT NULL
      )
    ''');
  }

  // New method to initialize the database
  Future<void> initializeDatabase() async {
    await _initDatabase();
  }

  Future<void> insertFavoriteMeal(Map<String, dynamic> meal) async {
    final db = await database;
    print('Inserting meal with values: $meal');
    try{
      await db.insert('favorite_recipes', meal,
          conflictAlgorithm: ConflictAlgorithm.replace);

    } catch(e){
      print('Error inserting meal: $e');
    }

  }

  Future<void> deleteFavoriteMeal(String recipeId) async {
    final db = await database;
    await db.delete('favorite_recipes', where: 'recipeId = ?', whereArgs: [recipeId]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('favorite_recipes');
    return result;
  }


}



