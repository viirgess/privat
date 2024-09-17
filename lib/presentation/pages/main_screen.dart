import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:privat_test_task/core/di/di.dart';
import 'package:privat_test_task/presentation/cubit/cached_movie/cached_movie_cubit.dart';
import 'package:privat_test_task/presentation/cubit/movie/movie_cubit.dart';
import 'package:privat_test_task/presentation/pages/movie_detail_screen.dart';
import 'package:privat_test_task/presentation/widgets/card_item.dart';
import 'package:privat_test_task/presentation/widgets/empty_list.dart';
import 'package:privat_test_task/presentation/widgets/input_field.dart';
import 'package:privat_test_task/presentation/theme/colors.dart';
import 'package:privat_test_task/presentation/theme/text_style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _movieCubit = getIt<MovieCubit>();
  final _cachedMovieCubit = getIt<CachedMovieCubit>();

  String query = '';
  bool hasInteracted = false;

  void updateQuery(String newQuery) {
    setState(() {
      query = newQuery;
      hasInteracted = true;
    });
  }

  void _movieStateListener(BuildContext context, MovieState state) {
    state.whenOrNull(
      loaded: (movies) {
        for (final movie in movies) {
          _cachedMovieCubit.insertMovie(movie);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                onQueryChanged: updateQuery,
                onFocus: () => setState(() => hasInteracted = true),
              ),
            ),
            Expanded(
              child: !hasInteracted
                  ? const EmptyList()
                  : (query.length < 2)
                      ? Center(
                          child: Text(
                            'Please enter at least 2 characters to search for movies',
                            textAlign: TextAlign.center,
                            style: TextStyleSource.body1.copyWith(
                              color: ColorsSource.blackBackground,
                            ),
                          ),
                        )
                      : BlocConsumer<MovieCubit, MovieState>(
                          bloc: _movieCubit,
                          listener: _movieStateListener,
                          builder: (context, state) {
                            return state.when(
                              initial: () => const SizedBox.shrink(),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              loaded: (movies) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  itemCount: movies.length,
                                  itemBuilder: (context, index) {
                                    final movie = movies[index];

                                    double rating = (movie.voteAverage != null)
                                        ? movie.voteAverage! / 10.0
                                        : 0.0;

                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(
                                            movieId: movie.id,
                                          ),
                                        ),
                                      ),
                                      child: CardItem(
                                        posterPath: movie.posterPath,
                                        title: movie.title,
                                        overview: movie.overview,
                                        rating: rating,
                                        withDecoration: true,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              error: (error) =>
                                  Center(child: Text('Error: $error}')),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
