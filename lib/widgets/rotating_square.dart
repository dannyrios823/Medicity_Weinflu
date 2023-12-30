import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/copys.dart';

class RotatingSquare extends StatelessWidget {
  final Animation<double> rotationAnimation;
  final Color selectedColor;

  const RotatingSquare({super.key, required this.rotationAnimation, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 80, height: 80, color: selectedColor),
              const Text(
                RetoCopys.medicine,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}