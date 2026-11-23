import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FabMenu extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onToggle;
  final VoidCallback? onOffRouteVisit;
  final VoidCallback? onCreateCustomer;
  final VoidCallback? onCreateBranch;

  const FabMenu({
    super.key,
    required this.isOpen,
    required this.onToggle,
    this.onOffRouteVisit,
    this.onCreateCustomer,
    this.onCreateBranch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOpen) ...[
          _buildMenuItem(
            label: 'Viếng thăm trái tuyến',
            icon: Icons.alt_route,
            onTap: () {
              onToggle();
              onOffRouteVisit?.call();
            },
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            label: 'Tạo khách hàng',
            icon: Icons.person_add_alt_1,
            onTap: () {
              onToggle();
              onCreateCustomer?.call();
            },
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            label: 'Tạo chi nhánh',
            icon: Icons.add_business,
            onTap: () {
              onToggle();
              onCreateBranch?.call();
            },
          ),
          const SizedBox(height: 8),
        ],

        // Main FAB button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isOpen ? AppColors.primary : AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(isOpen ? 28 : 16),
              boxShadow: const [
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
            child: Center(
              child: Icon(
                isOpen ? Icons.close : Icons.add,
                size: 24,
                color: isOpen ? Colors.white : AppColors.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Color(0x4D000000),
              offset: Offset(0, 1),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.onPrimaryContainer,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.onPrimaryContainer,
                letterSpacing: 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
