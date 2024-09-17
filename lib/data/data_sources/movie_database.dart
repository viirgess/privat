import 'package:path/path.dart';
import 'package:privat_test_task/domain/service/cached_movie_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:privat_test_task/domain/entities/movie.dart';

class MovieDatabase implements CachedMovieService {
  static final instance = MovieDatabase._init();
  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async =>
      _database ??= await _initDB('movies.db');

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, filePath),
        version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        overview TEXT NOT NULL,
        poster_path TEXT NOT NULL,
        vote_average REAL NOT NULL
      )
    ''');
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    final db = await database;

    await db.insert(
      'movies',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Movie>> loadMovies() async {
    final db = await database;
    return (await db.query('movies'))
        .map((json) => Movie.fromJson(json))
        .toList();
  }
}
