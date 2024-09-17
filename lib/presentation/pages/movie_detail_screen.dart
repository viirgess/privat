import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:privat_test_task/core/di/di.dart';

import 'package:privat_test_task/presentation/cubit/movie_details/movie_details_cubit.dart';

import 'package:privat_test_task/presentation/widgets/progress_indicator/progress_indicator_widget.dart';
import 'package:privat_test_task/presentation/theme/colors.dart';
import 'package:privat_test_task/core/utils/movie_url_utils.dart';
import 'package:privat_test_task/presentation/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({
    required this.movieId,
    super.key,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final _movieCubit = getIt<MovieDetailsCubit>();

  @override
  void initState() {
    super.initState();
    _movieCubit.loadMovieDetails(widget.movieId);
  }

  Future<void> _openDeeplink() async {
    final url = Uri.parse(MovieUrlUtils.getMovieDetailsPageUrl(widget.movieId));
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: _openDeeplink,
        child: const CircleAvatar(
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.chevron_right),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: TextStyleSource.body2.copyWith(
            color: ColorsSource.blackBackground,
          ),
        ),
      ),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        bloc: _movieCubit,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (movieDetails) {
              double rating = (movieDetails.voteAverage != null)
                  ? movieDetails.voteAverage! / 10.0
                  : 0.0;
              return SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 520,
                    child: Stack(
                      children: [
                        Image.network(
                          MovieUrlUtils.getPosterImageUrl(
                            movieDetails.posterPath,
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 500,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40, right: 12),
                            child: ProgressIndicatorWidget(
                              rating: rating,
                              isDetailedView: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetails.title,
                          style: TextStyleSource.body2.copyWith(
                            color: ColorsSource.blackBackground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rating: ${movieDetails.voteAverage}',
                          style: TextStyleSource.body1.copyWith(
                            color: ColorsSource.blackBackground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movieDetails.overview,
                          style: TextStyleSource.body1.copyWith(
                            color: ColorsSource.blackBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            },
            error: (error) => Center(
                child: Text(
              'Movie not found. Error $error',
              style: TextStyleSource.body1.copyWith(
                color: ColorsSource.blackBackground,
              ),
            )),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _movieCubit.close();
    super.dispose();
  }
}
