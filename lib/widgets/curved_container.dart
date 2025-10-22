import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Color color;
  final double height;
  final BorderRadius borderRadius;

  const CurvedContainer({
    super.key,
    this.color = const Color(0xFF3949AB),
    this.height = 150,
    this.borderRadius = const BorderRadius.only(
      bottomRight: Radius.circular(100),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
    );
  }
}