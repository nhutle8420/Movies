import 'dart:convert';
import 'package:movie_app/Database/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'KeyApiURL.dart';
import '../Models/movie.dart';
import 'package:http/http.dart' as http;


class Apii{
  List<Map<String, dynamic>> movies =[];
  var val;
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${KeyApi.aipKey}&page=2';
  static const _moviesingUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${KeyApi.aipKey}';

  Future<List<Movie>> getTrending() async {
    final resPonse = await http.get(Uri.parse(_trendingUrl));

    if (resPonse.statusCode == 200) {
      List<dynamic> data = json.decode(resPonse.body)['results'];
      List<Movie> movies = data.map((json) => Movie.fromJson(json)).toList();

      // Save data to SQLite
      DatabaseHelper dbHelper = DatabaseHelper();
      for (var movie in movies) {
        await dbHelper.insertMovie(movie);
      }

      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchMovies() async {
    final resPonse = await http.get(Uri.parse(_moviesingUrl));

    if (resPonse.statusCode == 200) {
      List<dynamic> data = json.decode(resPonse.body)['results'];
      List<Movie> movies = data.map((json) => Movie.fromJson(json)).toList();

      // Save data to SQLite
      DatabaseHelper dbHelper = DatabaseHelper();
      for (var movie in movies) {
        await dbHelper.insertMovie(movie);
      }

      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
  }

