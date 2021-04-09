import 'package:flutter/material.dart';

class MoreEvents extends StatelessWidget {
  const MoreEvents({
    @required this.onTap,
    this.value,
    this.size = 25,
    this.backgroundColor,
    this.bannerTextStyle,
  });

  final int value;
  final double size;
  final VoidCallback onTap;
  final TextStyle bannerTextStyle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomPaint(
      size: Size(size, size),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
            width: size,
            height: size,
            child: Padding(
              padding: EdgeInsets.only(top: value > 9 ? 0 : 0.5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '+$value',
                  style: bannerTextStyle ??
                      textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                  maxLines: 2,
                ),
              ),
            )),
      ),
      painter: _TrianglePainter(paintBrushColor: backgroundColor),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({this.paintBrushColor});

  final Color paintBrushColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBrush = Paint();
    paintBrush.color = paintBrushColor ?? Colors.red.withOpacity(0.5);

    // reversed triangle
    final reversePath = Path();
    reversePath.lineTo(0, 0);
    reversePath.lineTo(size.width, 0);
    reversePath.lineTo(0, size.width);
    reversePath.lineTo(0, 0);
    reversePath.close();

    canvas.drawPath(reversePath, paintBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
