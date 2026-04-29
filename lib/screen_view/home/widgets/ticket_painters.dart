import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../../constants/color_const.dart';

class TicketClipper extends CustomClipper<Path> {
  final double bottomSectionHeight;
  final double cutoutRadius = 15.0;

  TicketClipper({this.bottomSectionHeight = 70.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final cutoutY = size.height - bottomSectionHeight;

    path.lineTo(0.0, cutoutY - cutoutRadius);
    path.arcToPoint(
      Offset(0.0, cutoutY + cutoutRadius),
      radius: Radius.circular(cutoutRadius),
      clockwise: true,
    );
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(0.0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, cutoutY + cutoutRadius);
    path.arcToPoint(
      Offset(size.width, cutoutY - cutoutRadius),
      radius: Radius.circular(cutoutRadius),
      clockwise: true,
    );
    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width, 0.0, size.width - 20, 0.0);
    path.lineTo(20, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, 20);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6, dashSpace = 4, startX = 20;
    final paint = Paint()
      ..color = AppColors.greyColor.withValues(alpha: 0.4)
      ..strokeWidth = 1.5;
    while (startX + dashWidth <= size.width - 20) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.bgThemeColorPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14159,
      3.14159,
    );

    double dashWidth = 3, dashSpace = 4;
    for (ui.PathMetric measurePath in path.computeMetrics()) {
      double distance = 0;
      while (distance < measurePath.length) {
        canvas.drawPath(
          measurePath.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
