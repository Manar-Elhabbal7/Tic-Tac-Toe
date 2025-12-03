import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Animation<double> fade;
  final Animation<double> scale;

  const Logo({required this.fade, required this.scale});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(
        scale: scale,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFCA311).withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Image.asset(
            'assets/tic_logo.png',
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}
