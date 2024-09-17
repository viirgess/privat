import 'package:flutter/material.dart';
import 'package:privat_test_task/presentation/theme/colors.dart';
import 'package:privat_test_task/presentation/theme/text_style.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.movie_creation_outlined,
            size: 80,
            color: ColorsSource.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'No movies to display',
              style: TextStyleSource.body2.copyWith(
                color: ColorsSource.grey,
              ),
            ),
          ),
          Text(
            'Start searching for your favorite movies!',
            style: TextStyleSource.body1.copyWith(
              color: ColorsSource.grey,
            ),
          ),
        ],
      ),
    );
  }
}
