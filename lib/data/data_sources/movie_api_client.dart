import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:privat_test_task/domain/entities/movie_detail.dart';
import 'package:privat_test_task/domain/entities/movie.dart';
import 'package:privat_test_task/domain/service/movie_service.dart';
import 'package:privat_test_task/core/utils/movie_url_utils.dart';

@Injectable(as: MovieService)
class MovieApiClient implements MovieService {
  final _dio = Dio();
  final apiKey = dotenv.env['API_KEY'];

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        MovieUrlUtils.getSearchMoviesUrl(),
        queryParameters: {
          'api_key': apiKey,
          'query': query,
        },
      );

      if (response.statusCode == 200) {
        List<Movie> movies = (response.data['results'] as List<dynamic>)
            .map((movie) => Movie.fromJson(movie))
            .toList();

        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e, s) {
      log('Failed to load movies', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<MovieDetail> loadMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        MovieUrlUtils.getMovieDetailsUrl(movieId),
        queryParameters: {
          'api_key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        return MovieDetail.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e, s) {
      log(
        'Error occurred while fetching movie details',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
