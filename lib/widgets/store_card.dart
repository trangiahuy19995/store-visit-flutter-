import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../theme/app_colors.dart';

class StoreCard extends StatelessWidget {
  final StoreItem store;
  final VoidCallback onVisitPressed;

  const StoreCard({
    super.key,
    required this.store,
    required this.onVisitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Store Icon + Headline
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

          // Subtitle: Branch Code
          Text(
            'Mã chi nhánh: ${store.branchCode}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.25,
            ),
          ),
          const SizedBox(height: 16),

          // Assistive Status Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: store.status.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4D000000), // 30% black
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: Color(0x26000000), // 15% black
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              store.status.label,
              style: TextStyle(
                color: store.status.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Primary Button: "Thăm viếng"
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onSurfaceVariant,
                side: const BorderSide(color: AppColors.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              onPressed: onVisitPressed,
              child: const Text(
                'Thăm viếng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
