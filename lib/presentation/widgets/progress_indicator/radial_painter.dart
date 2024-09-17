import 'dart:math';

import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  RadialPainter({
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const linesMargin = 3;
    final offset = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);

    final backgroungPaint = Paint();
    backgroungPaint.color = fillColor;
    backgroungPaint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroungPaint);

    final freePaint = Paint();
    freePaint.color = freeColor;
    freePaint.style = PaintingStyle.stroke;
    freePaint.strokeWidth = lineWidth;
    canvas.drawArc(arcRect, pi * 2 * percent - (pi / 2),
        pi * 2 * (1.0 - percent), false, freePaint);

    final feelPaint = Paint();
    feelPaint.color = lineColor;
    feelPaint.style = PaintingStyle.stroke;
    feelPaint.strokeWidth = lineWidth;
    feelPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, pi * 2 * percent, false, feelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
