import 'dart:convert';
import 'package:movie_app/Database/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'KeyApiURL.dart';
import '../Models/movie.dart';
import 'package:http/http.dart' as http;
class Apii{
  List<Map<String, dynamic>> movies =[];
  var val;
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${KeyApi.aipKey}';
  static const _moviesingUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${KeyApi.aipKey}';


  Future<List<Movie>> gettrending() async {
    final response = await http.get(Uri.parse(_trendingUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
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
    final response = await http.get(Uri.parse(_moviesingUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
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

