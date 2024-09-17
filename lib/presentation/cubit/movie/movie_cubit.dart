import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:privat_test_task/domain/entities/movie.dart';
import 'package:privat_test_task/domain/service/movie_service.dart';

part 'movie_state.dart';
part 'movie_cubit.freezed.dart';

@singleton
class MovieCubit extends Cubit<MovieState> {
  final MovieService _movieService;

  MovieCubit(this._movieService) : super(const _Initial());

  Future<void> searchMovies(String query) async {
    try {
      emit(const _Loading());
      final movies = await _movieService.searchMovies(query);
      emit(_Loaded(movies));
    } catch (e) {
      emit(_Error(e));
    }
  }

  void clearSearch() {
    emit(const _Loaded([]));
  }
}
