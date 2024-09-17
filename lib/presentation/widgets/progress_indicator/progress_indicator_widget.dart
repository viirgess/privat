import 'package:flutter/material.dart';
import 'package:privat_test_task/presentation/widgets/progress_indicator/radial_percent_widget.dart';
import 'package:privat_test_task/presentation/theme/colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double rating;
  final bool isDetailedView;

  const ProgressIndicatorWidget({
    required this.rating,
    required this.isDetailedView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = rating >= 0.8
        ? [ColorsSource.lightGreen, ColorsSource.darkGreen]
        : rating >= 0.5
            ? [ColorsSource.lightYellow, ColorsSource.darkYellow]
            : [ColorsSource.lightPink, ColorsSource.darkPink];

    return Center(
      child: Container(
        width: isDetailedView ? 100 : 60,
        height: isDetailedView ? 100 : 60,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: RadialPercentWidget(
          percent: rating,
          fillColor: ColorsSource.blackBackground,
          lineColor: colors[0],
          freeColor: colors[1],
          lineWidth: isDetailedView ? 10 : 5,
          child: Text(
            '${(rating * 100).toInt()}%',
            style: TextStyle(
              color: ColorsSource.white,
              fontSize: isDetailedView ? 14 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
