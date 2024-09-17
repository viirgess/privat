import 'package:privat_test_task/domain/entities/movie.dart';

abstract class CachedMovieService {
  Future<void> insertMovie(Movie movie);
  Future<List<Movie>> loadMovies();
}
