import 'package:get/state_manager.dart';
import 'package:tmdb/constants.dart';
import 'package:tmdb/model/detailedMovieModel.dart';
import 'package:tmdb/model/trendingMovieModel.dart';
import 'package:tmdb/services/apiService.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  List<TrendingMovie> trendingMovies = List<TrendingMovie>().obs;
  List<TrendingMovie> searchedMovies = List<TrendingMovie>().obs;
  var movie = DetailedMovie(
    bgURL: null,
    category: null,
    id: null,
    overview: null,
    posterURL: null,
    rating: null,
    releaseYear: null,
    title: null,
    budget: null,
    cast: null,
    reparto: null,
    revenue: null,
    runtime: null,
  ).obs;
  var selectedMovie = TrendingMovie(
          bgURL: null,
          category: null,
          id: null,
          overview: null,
          posterURL: null,
          rating: null,
          releaseYear: null,
          title: null)
      .obs;

  @override
  void onInit() {
    getTrendingMovies();
    super.onInit();
  }

  void selectedMovies(int index) {
    selectedMovie(trendingMovies[index]);
  }

  void getSearchedMovie(String movieName) async {
    isLoading(true);
    var _movies = await APIService.getSearchedMovie(movieName);
    if (_movies != null) {
      searchedMovies = _movies;
    }
    isLoading(false);
  }

  void getTrendingMovies() async {
    isLoading(true);
    var _movies = await APIService.getTrendingMovie();
    if (_movies != null) {
      trendingMovies = _movies;
      selectedMovies(0);
    }
    isLoading(false);
  }

  void getMovieDetail(String id) async {
    isLoading(true);
    var _movie = await APIService.getMovieDetail(id);
    if (_movie != null) {
      movie(_movie);
    }
    isLoading(false);
  }

  void launchURL(String query) async {
    final url = '$youtubeSearch$query+offical+trailer'.toLowerCase();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
