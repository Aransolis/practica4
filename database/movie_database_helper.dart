import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../models/popular_model.dart';

class Movie_Database_Helper {
  static final nombreBD = "MovieDB";
  static final verisonBD = 1;
  static final _TBLFavMovies = "tblFavMovies";

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, nombreBD);
    return await openDatabase(
      rutaBD,
      version: verisonBD,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_TBLFavMovies(id INTEGER PRIMARY KEY, backdrop_path VARCHAR(250), original_language VARCHAR(50), original_title VARCHAR(50),overview VARCHAR(250), popularity VARCHAR(50), poster_path VARCHAR(250),title VARCHAR(50), vote_average VARCHAR(50), vote_count INTEGER)");
  }

  Future<List<PopularModel>?> getFavoritesMovies() async {
    var conexion = await database;
    var moviesList = await conexion.query(_TBLFavMovies);
    return moviesList.map((movie) => PopularModel.fromJSON(movie)).toList();
  }

  Future<int> addToFavorites(Map<String, dynamic> row) async {
    var conexion = await database;
    print(row);
    return conexion.insert(_TBLFavMovies, row);
  }

  Future<int> removeFromFavorites(int id) async {
    var conexion = await database;
    return conexion.delete(_TBLFavMovies, where: "id = ?", whereArgs: [id]);
  }

  Future<bool> seekInFavorites(int id) async {
    var conexion = await database;
    var favorite =
        await conexion.query(_TBLFavMovies, where: "id = ?", whereArgs: [id]);
    if (favorite.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
