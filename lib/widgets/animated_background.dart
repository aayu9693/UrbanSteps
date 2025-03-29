import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff4285F4), Color(0xff34A853)],
        ),
      ),
    ).animate()
        .fadeIn(duration: 1000.ms)
        .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.2))
        .animate(onPlay: (controller) => controller.repeat())
        .tint(color: Colors.blue.withOpacity(0.2), duration: 3000.ms)
        .tint(color: Colors.green.withOpacity(0.2), duration: 3000.ms);
  }
}

