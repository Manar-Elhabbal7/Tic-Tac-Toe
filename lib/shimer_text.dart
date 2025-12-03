import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerText extends StatelessWidget {
  final Animation<double> shimmer;
  final Animation<double> textFade;
  final Animation<Offset> slide;

  const ShimmerText({
    required this.shimmer,
    required this.textFade,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: textFade,
      child: SlideTransition(
        position: slide,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFFFCA311),
                Color(0xFFFFD700),
                Color(0xFFFCA311),
              ],
              stops: [
                shimmer.value - 0.3,
                shimmer.value,
                shimmer.value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: Text(
            'Tic Tac Toe',
            style: GoogleFonts.pacifico(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
