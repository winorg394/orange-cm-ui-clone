import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';
import 'dart:math' as math;

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 50), () {
        Get.offAllNamed(Routes.ONBOARDING);
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.3, 0.6, 1.0],
            colors: [
              Colors.white,
              const Color(0xFFFFF5EC),  // Very light orange-white
              const Color(0xFFFFE8D6),  // Soft peach
              const Color(0xFFFFD6B8),  // Light warm orange
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container with Shadow
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B00).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background subtle pattern
                          Opacity(
                            opacity: 0.1,
                            child: Icon(
                              Icons.hexagon,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          // Text
                          Text(
                            'Max it',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Loading indicator at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  AnimatedLoadingIndicator(),
                  SizedBox(height: 24),
                  AnimatedLoadingText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLoadingIndicator extends StatefulWidget {
  const AnimatedLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<AnimatedLoadingIndicator> createState() => _AnimatedLoadingIndicatorState();
}

class _AnimatedLoadingIndicatorState extends State<AnimatedLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating circle
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: CustomPaint(
                  painter: LoadingPainter(
                    color: const Color(0xFFFF6B00),
                    strokeWidth: 2,
                  ),
                  size: const Size(50, 50),
                ),
              );
            },
          ),
          // Middle rotating circle
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_rotationAnimation.value * 1.5,
                child: CustomPaint(
                  painter: LoadingPainter(
                    color: const Color(0xFFFF6B00).withOpacity(0.5),
                    strokeWidth: 1.5,
                  ),
                  size: const Size(35, 35),
                ),
              );
            },
          ),
          // Pulsing center dot
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B00),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6B00).withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnimatedLoadingText extends StatelessWidget {
  const AnimatedLoadingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Text(
            'Loading...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

class LoadingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  LoadingPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    // Draw arc with gradient
    final gradient = SweepGradient(
      colors: [
        color.withOpacity(0.0),
        color.withOpacity(0.3),
        color.withOpacity(0.5),
        color.withOpacity(0.7),
        color,
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    paint.shader = gradient.createShader(rect);
    canvas.drawArc(
      rect,
      0,
      2 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
