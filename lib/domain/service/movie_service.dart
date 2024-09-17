import 'package:privat_test_task/domain/entities/movie_detail.dart';
import 'package:privat_test_task/domain/entities/movie.dart';

abstract class MovieService {
  Future<List<Movie>> searchMovies(String query);
  Future<MovieDetail> loadMovieDetails(int movieId);
}
