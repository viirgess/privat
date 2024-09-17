part of 'cached_movie_cubit.dart';

@freezed
class CachedMovieState with _$CachedMovieState {
  const factory CachedMovieState.initial() = _Initial;
  const factory CachedMovieState.loaded(List<Movie> movies) = _Loaded;
  const factory CachedMovieState.loading() = _Loading;
  const factory CachedMovieState.error(Object? error) = _Error;
}
