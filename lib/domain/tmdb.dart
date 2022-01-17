import 'package:movie/model/movie.dart';

abstract class Tmdb {
  Future<List<Movie>> fetchMovies(String query);
}
