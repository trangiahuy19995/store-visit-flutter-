import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../theme/app_colors.dart';

class StoreDetailBottomSheet extends StatelessWidget {
  final StoreItem store;
  final VoidCallback onStartVisit;

  const StoreDetailBottomSheet({
    super.key,
    required this.store,
    required this.onStartVisit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000), // 15% black
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Color(0x4D000000), // 30% black
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outline,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Store Info Card Container
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store Icon + Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.storefront_outlined,
                              size: 32,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            store.name,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: AppColors.onSurface,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Scheduled Time
                    Text(
                      store.dateSchedule,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Key-Value Metadata Rows
                    _buildMetaRow('Kênh', store.channel),
                    const SizedBox(height: 12),
                    _buildMetaRow('Loại khách hàng', store.customerType),
                    const SizedBox(height: 12),
                    _buildMetaRow('Phương thức mua bán', store.paymentMethod),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Distance Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Khoảng cách',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.15,
                    ),
                  ),
                  Text(
                    store.distance,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Pin Map Container (380x380 in Figma)
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.outline),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: Stack(
                    children: [
                      // Map Background simulation
                      Container(
                        color: const Color(0xFFE8ECE9),
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: _MapGridPainter(),
                        ),
                      ),

                      // Center: Markers
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Current location marker (blue pulse)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF2196F3).withOpacity(0.2),
                              ),
                              child: Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF2196F3),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 35),
                            // Destination Map Pin
                            const Icon(
                              Icons.location_on,
                              size: 32,
                              color: Color(0xFFE53935),
                            ),
                          ],
                        ),
                      ),

                      // Floating Assistive Chip: "Mở Google Map"
                      Positioned(
                        top: 21,
                        left: 24,
                        child: GestureDetector(
                          onTap: () {
                            // Open external map
                          },
                          child: Container(
                            height: 32,
                            padding: const EdgeInsets.only(left: 8, right: 16),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x4D000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.directions,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Mở Google Map',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Floating Map Controls (Right side)
                      Positioned(
                        top: 21,
                        right: 21,
                        child: Column(
                          children: [
                            // GPS Recenter Button
                            _buildMapControlButton(
                              icon: Icons.my_location,
                              onTap: () {},
                            ),
                            const SizedBox(height: 100),
                            // Zoom In & Out Container
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildMapZoomButton(
                                    icon: Icons.add,
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 2),
                                  _buildMapZoomButton(
                                    icon: Icons.remove,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Button: "Bắt đầu viếng thăm"
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  onPressed: onStartVisit,
                  child: const Text(
                    'Bắt đầu viếng thăm',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Home indicator bar
              Center(
                child: Container(
                  width: 108,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF181D18).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.25,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.25,
          ),
        ),
      ],
    );
  }

  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderDefault),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 2),
              blurRadius: 30,
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _buildMapZoomButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
        ),
      ),
    );
  }
}

/// Simulated vector roads/streets for realistic map preview
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final secondaryRoadPaint = Paint()
      ..color = const Color(0xFFF9F5ED)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw stylized roads
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.45),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.45, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.6, size.height),
      secondaryRoadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.7),
      secondaryRoadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
