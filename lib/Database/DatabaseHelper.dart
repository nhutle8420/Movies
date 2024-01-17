import 'package:movie_app/Models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies_database.db');
    print('-------'+path+'------');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Movie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        original_title TEXT ,
        overview TEXT ,
        poster_path TEXT ,
        release_date TEXT ,
        vote_average INTEGER,
        backdrop_path TEXT ,
        vote_count INTEGER ,
        popularity INTEGER
        
      )
    ''');
  }

  Future<int> insertMovie(Movie movie) async {
    Database db = await this.db;
    return await db.insert('Movie', movie.ToMap());
  }

  Future<List<Movie>> getMovies() async {
    Database db = await this.db;
    List<Map<String, dynamic>> result = await db.query('movie');
    return result.map((map) => Movie.fromJson(map)).toList();
  }

}

