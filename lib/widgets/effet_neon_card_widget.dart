import 'package:flutter/material.dart';

class GlowingBorderCard extends StatefulWidget {
  final Widget child;

  const GlowingBorderCard({super.key, required this.child});

  @override
  State<GlowingBorderCard> createState() => _GlowingBorderCardState();
}

class _GlowingBorderCardState extends State<GlowingBorderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // lent
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return CustomPaint(
          painter: GlowingBorderPainter(progress: _animation.value),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0E4B6E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress;

  GlowingBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final borderRadius = 16.0;

    // Deux pics lumineux opposés à 180°
    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 6.2831, // 2π
        colors: [
          Colors.transparent,
          Colors.cyanAccent,
          Colors.transparent,
          Colors.transparent,
          Colors.cyanAccent,
          Colors.transparent,
        ],
        stops: [
          _wrap(progress - 0.03), // Lumière 1 (avant le pic)
          _wrap(progress),       // Lumière 1 (pic)
          _wrap(progress + 0.03),// Lumière 1 (après le pic)

          _wrap(progress + 0.47),// Lumière 2 (avant le pic - 180°)
          _wrap(progress + 0.5), // Lumière 2 (pic)
          _wrap(progress + 0.53),// Lumière 2 (après le pic)
        ],
        transform: GradientRotation(progress * 6.2831),
      ).createShader(rect)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    canvas.drawRRect(rrect, paint);
  }

  double _wrap(double value) => value % 1;

  @override
  bool shouldRepaint(covariant GlowingBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
