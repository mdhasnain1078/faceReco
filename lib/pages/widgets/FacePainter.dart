import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  FacePainter({required this.imageSize, required this.face});
  final Size imageSize;
  double? scaleX, scaleY;
  Face? face;
  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    Paint paint;

    if (this.face!.headEulerAngleY! > 10 || this.face!.headEulerAngleY! < -10) {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.red;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green;
    }

    scaleX = size.width / imageSize.width;
    scaleY = size.height / imageSize.height;

    _drawCircle(
      canvas: canvas,
      rect: face!.boundingBox,
      imageSize: imageSize,
      widgetSize: size,
      scaleX: scaleX ?? 1,
      scaleY: scaleY ?? 1,
      paint: paint,
    );
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
  }
}

void _drawCircle({
  required Canvas canvas,
  required Rect rect,
  required Size imageSize,
  required Size widgetSize,
  double scaleX = 1,
  double scaleY = 1,
  required Paint paint,
}) {
  // Calculate the center and radius of the bounding box
  double centerX = (rect.left + rect.width / 2) * scaleX;
  double centerY = (rect.top + rect.height / 2) * scaleY;
  double radius =
      (rect.width > rect.height ? rect.width / 2 : rect.height / 2) *
          (scaleX > scaleY ? scaleX : scaleY);

  canvas.drawCircle(Offset(centerX, centerY), radius, paint);
}
