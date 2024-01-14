import 'dart:convert';

import 'KeyApiURL.dart';
import '../Models/movie.dart';
import 'package:http/http.dart' as http;
class Apii{
  List<Map<String, dynamic>> movies =[];
  var val;
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${KeyApi.aipKey}';
  static const _moviesingUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${KeyApi.aipKey}';


  Future<List<Movie>> gettrending() async {
    final res = await http.get(Uri.parse(_trendingUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body)['results'] as List;

      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('ERRO: ------');
    }
  }
    Future<List<Movie>> getMovies() async {
      final res = await http.get(Uri.parse(_moviesingUrl));
      if (res.statusCode == 200) {
        final data = json.decode(res.body)['results'] as List;

        return data.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('ERRO: ------');
      }
    }


  Future<List<Movie>> getSearch() async {
    final res = await http.get(Uri.parse(_moviesingUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body)['results'] as List;

      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('ERRO: ------');
    }
  }
  }

