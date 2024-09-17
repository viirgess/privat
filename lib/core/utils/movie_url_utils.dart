abstract class MovieUrlUtils {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String pageUrl = 'https://themoviedb.org/movie';

  static String getSearchMoviesUrl() {
    return '$baseUrl/search/movie';
  }

  static String getMovieDetailsUrl(int movieId) {
    return '$baseUrl/movie/$movieId';
  }

  static String getPosterImageUrl(String posterPath) {
    return '$imageBaseUrl/$posterPath';
  }

  static String getMovieDetailsPageUrl(int movieId) {
    return '$pageUrl/$movieId';
  }
}
