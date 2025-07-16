import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSplitSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSplitSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSplitSliderState createState() => _CustomSplitSliderState();
}

class _CustomSplitSliderState extends State<CustomSplitSlider> {
  @override
  Widget build(BuildContext context) {
    double sliderHeight = 75.0;
    double dotSize = 20.sp;
    double gap = 30.sp; // Increased gap between the two slider bars

    return LayoutBuilder(
      builder: (context, constraints) {
        final sliderWidth = constraints.maxHeight;
        return SizedBox(
          width: sliderWidth,
          height: sliderHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(sliderWidth, 20),
                  painter: SplitTrackPainter(dotSize: dotSize, gap: gap),
                ),
              ),
              // Center the red bar using Align
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 1 + dotSize / 2 - 1,
                  ), // vertical offset
                  width: 2,
                  height: dotSize + 15,
                  color: Colors.red,
                ),
              ),
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${(widget.value * 100).toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0.0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 0.0,
                  ),
                ),
                child: Slider(
                  value: widget.value,
                  onChanged: widget.onChanged,
                  min: 0,
                  max: 1,
                  divisions: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SplitTrackPainter extends CustomPainter {
  final double dotSize;
  final double gap;

  SplitTrackPainter({this.dotSize = 8.0, this.gap = 20.0});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final leftPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Colors.white, Colors.grey],
          ).createShader(Rect.fromLTWH(0, 0, centerX - gap / 2, size.height));

    final rightPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Colors.grey, Colors.black87],
          ).createShader(
            Rect.fromLTWH(centerX + gap / 2, 0, centerX - gap / 2, size.height),
          );

    final radius = Radius.circular(10);
    final leftRect = RRect.fromLTRBR(0, 0, centerX - gap / 2, dotSize, radius);
    final rightRect = RRect.fromLTRBR(
      centerX + gap / 2,
      0,
      size.width,
      dotSize,
      radius,
    );

    canvas.drawRRect(leftRect, leftPaint);
    canvas.drawRRect(rightRect, rightPaint);

    final tickPaint = Paint()..color = Colors.white;
    int ticks = 5;
    for (int i = 1; i < ticks; i++) {
      canvas.drawCircle(
        Offset(i * (centerX - gap / 2) / ticks, dotSize / 2),
        2,
        tickPaint,
      );
      canvas.drawCircle(
        Offset(
          centerX + gap / 2 + i * (centerX - gap / 2) / ticks,
          dotSize / 2,
        ),
        2,
        tickPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
