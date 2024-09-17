part of 'movie_details_cubit.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.initial() = _Initial;
  const factory MovieDetailsState.loading() = _Loading;
  const factory MovieDetailsState.loaded(MovieDetail movieDetails) = _Loaded;
  const factory MovieDetailsState.error(Object? error) = _Error;
}
