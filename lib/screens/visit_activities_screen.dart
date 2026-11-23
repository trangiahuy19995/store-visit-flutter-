import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../theme/app_colors.dart';

class VisitActivitiesScreen extends StatelessWidget {
  final StoreItem store;

  const VisitActivitiesScreen({
    super.key,
    required this.store,
  });

  static const List<VisitActivityItem> _activities = [
    VisitActivityItem(
      id: '01',
      title: 'Thông tin khách hàng',
      icon: Icons.person_outline,
    ),
    VisitActivityItem(
      id: '02',
      title: 'Thu thập thông tin mua hàng',
      icon: Icons.shopping_bag_outlined,
    ),
    VisitActivityItem(
      id: '03',
      title: 'Hoạt động xử lý sự cố',
      icon: Icons.report_problem_outlined,
    ),
    VisitActivityItem(
      id: '04',
      title: 'Chương trình hỗ trợ bán hàng',
      icon: Icons.card_giftcard_outlined,
    ),
    VisitActivityItem(
      id: '05',
      title: 'Thu thập thông tin giá NET',
      icon: Icons.request_quote_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.onSurface,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hoạt động thăm viếng',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: AppColors.onSurface,
            height: 1.27,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: List.generate(_activities.length, (index) {
                        final item = _activities[index];
                        return _buildActivityItem(
                          context: context,
                          item: item,
                          isLast: index == _activities.length - 1,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Action Area
            Container(
              color: AppColors.surfaceContainer,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
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
                      onPressed: () {
                        // Handle End Visit
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã hoàn tất viếng thăm: ${store.name}'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Kết thúc viếng thăm',
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
                  // Navigation Bar Home Indicator
                  Container(
                    width: 108,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF181D18).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required VisitActivityItem item,
    required bool isLast,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mở: ${item.title}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: AppColors.onSurface,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.onSurface,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.outline,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 52,
            endIndent: 16,
            color: AppColors.outlineVariant,
          ),
      ],
    );
  }
}
