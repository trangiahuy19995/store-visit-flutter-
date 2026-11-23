import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/vfm_colors.dart';
import 'visit/store_visit_home_screen.dart';
import 'requests/requests_screen.dart';
import 'reports/reports_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    StoreVisitHomeScreen(),
    RequestsScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        color: AppColors.surfaceContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 64,
              child: Row(
                children: [
                  _buildNavItem(0, Icons.location_on, 'Viếng thăm'),
                  _buildNavItem(1, Icons.assignment_outlined, 'Yêu cầu'),
                  _buildNavItem(2, Icons.bar_chart_outlined, 'Báo cáo'),
                  _buildNavItem(3, Icons.more_horiz, 'Mở rộng'),
                ],
              ),
            ),
            // Home Indicator Bar
            Container(
              height: 20,
              alignment: Alignment.center,
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
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFD8FFEE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 22,
                    color: isSelected ? VfmColors.primaryGreen : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0.3,
                  color: isSelected ? VfmColors.primaryGreen : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
