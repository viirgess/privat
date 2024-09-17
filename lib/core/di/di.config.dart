// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/movie_api_client.dart' as _i241;
import '../../domain/service/movie_service.dart' as _i929;
import '../../presentation/cubit/cached_movie/cached_movie_cubit.dart' as _i316;
import '../../presentation/cubit/movie/movie_cubit.dart' as _i900;
import '../../presentation/cubit/movie_details/movie_details_cubit.dart'
    as _i1047;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i316.CachedMovieCubit>(() => _i316.CachedMovieCubit());
    gh.factory<_i929.MovieService>(() => _i241.MovieApiClient());
    gh.singleton<_i900.MovieCubit>(
        () => _i900.MovieCubit(gh<_i929.MovieService>()));
    gh.factory<_i1047.MovieDetailsCubit>(
        () => _i1047.MovieDetailsCubit(gh<_i929.MovieService>()));
    return this;
  }
}
