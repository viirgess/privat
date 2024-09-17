import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:privat_test_task/data/data_sources/movie_database.dart';
import 'package:privat_test_task/domain/entities/movie.dart';

part 'cached_movie_state.dart';
part 'cached_movie_cubit.freezed.dart';

@singleton
class CachedMovieCubit extends Cubit<CachedMovieState> {
  final _db = MovieDatabase.instance;

  CachedMovieCubit() : super(const _Initial());

  Future<void> insertMovie(Movie movie) async {
    try {
      await _db.insertMovie(movie);
    } catch (e) {
      emit(_Error(e));
    }
  }

  Future<void> loadMovies() async {
    try {
      emit(const _Loading());
      final movies = await _db.loadMovies();
      emit(_Loaded(movies));
    } catch (e) {
      emit(_Error(e));
    }
  }
}
