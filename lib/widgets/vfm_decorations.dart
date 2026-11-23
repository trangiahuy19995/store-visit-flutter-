import 'package:flutter/material.dart';
import '../theme/vfm_colors.dart';

class VfmLogo extends StatelessWidget {
  final double size;

  const VfmLogo({super.key, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7E7E7), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Wheat icon / Brand insignia
            Icon(
              Icons.grain,
              size: size * 0.45,
              color: VfmColors.yellowAccent,
            ),
            const SizedBox(height: 4),
            Text(
              'VFM',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: size * 0.18,
                letterSpacing: 2,
                color: VfmColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VfmCornerDecorations extends StatelessWidget {
  const VfmCornerDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Left yellow curved wave
          Positioned(
            left: -40,
            bottom: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    VfmColors.yellowAccent.withOpacity(0.35),
                    VfmColors.yellowLight.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Right yellow curved wave
          Positioned(
            right: -50,
            bottom: -50,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    VfmColors.yellowAccent.withOpacity(0.3),
                    VfmColors.yellowLight.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
