import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/model/detailedMovieModel.dart';
import 'package:tmdb/model/trendingMovieModel.dart';
import '../constants.dart';

class APIService {
  static var client = http.Client();
  static Future<List<TrendingMovie>> getTrendingMovie() async {
    http.Response response = await client.get(trendingEndPoint);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      List<TrendingMovie> _movies = <TrendingMovie>[];
      for (var movie in data) {
        _movies.add(TrendingMovie.fromMap(movie));
      }
      return _movies;
    } else {
      return null;
    }
  }

  static Future<DetailedMovie> getMovieDetail(String id) async {
    http.Response response =
        await client.get("$movieEndPoint$id$apiKey$repartoEndPoint");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailedMovie _detailedMovie = DetailedMovie.fromMap(data);
      return _detailedMovie;
    } else {
      return null;
    }
  }

  static Future<List<TrendingMovie>> getSearchedMovie(String movieName) async {
    print("Search");
    http.Response response = await client.get("$searchMovie" + movieName);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      List<TrendingMovie> _movies = <TrendingMovie>[];
      for (var movie in data) {
        _movies.add(TrendingMovie.fromMap(movie));
      }
      return _movies;
    } else {
      return null;
    }
  }
}
