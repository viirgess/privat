import 'package:flutter/material.dart';
import 'package:privat_test_task/presentation/widgets/progress_indicator/progress_indicator_widget.dart';
import 'package:privat_test_task/presentation/theme/colors.dart';
import 'package:privat_test_task/core/utils/movie_url_utils.dart';
import 'package:privat_test_task/presentation/theme/text_style.dart';

class CardItem extends StatelessWidget {
  final String? posterPath;
  final String? title;
  final String? overview;
  final double rating;
  final bool withDecoration;

  const CardItem({
    super.key,
    required this.posterPath,
    required this.title,
    required this.overview,
    required this.rating,
    required this.withDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: withDecoration
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          posterPath != null
              ? SizedBox(
                  width: 120,
                  height: 160,
                  child: Stack(
                    children: [
                      Image.network(
                        MovieUrlUtils.getPosterImageUrl(posterPath ?? ''),
                        width: 100,
                        height: 155,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported,
                              size: 100);
                        },
                      ),
                      Positioned(
                        left: 60,
                        top: 100,
                        child: ProgressIndicatorWidget(
                          rating: rating,
                          isDetailedView: false,
                        ),
                      ),
                    ],
                  ),
                )
              : const Icon(Icons.image_not_supported, size: 100),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'No title available',
                  style: TextStyleSource.body2.copyWith(
                    color: ColorsSource.blackBackground,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Text(
                    overview ?? 'No description available',
                    style: TextStyleSource.body1.copyWith(
                      color: ColorsSource.grey,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
