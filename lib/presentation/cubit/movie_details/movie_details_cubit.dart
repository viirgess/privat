import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:privat_test_task/domain/entities/movie_detail.dart';
import 'package:privat_test_task/domain/service/movie_service.dart';

part 'movie_details_state.dart';
part 'movie_details_cubit.freezed.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieService _service;

  MovieDetailsCubit(this._service) : super(const _Initial());

  Future<void> loadMovieDetails(int movieId) async {
    try {
      emit(const _Loading());
      final details = await _service.loadMovieDetails(movieId);
      emit(_Loaded(details));
    } catch (e) {
      emit(_Error(e));
    }
  }
}
