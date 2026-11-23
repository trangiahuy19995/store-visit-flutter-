import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../theme/app_colors.dart';
import '../widgets/store_card.dart';
import '../widgets/fab_menu.dart';
import '../widgets/store_detail_bottom_sheet.dart';
import 'visit_activities_screen.dart';

class StoreVisitScreen extends StatefulWidget {
  const StoreVisitScreen({super.key});

  @override
  State<StoreVisitScreen> createState() => _StoreVisitScreenState();
}

class _StoreVisitScreenState extends State<StoreVisitScreen> {
  int _selectedNavIndex = 0;
  bool _isFabMenuOpen = false;

  // Stores from Figma Design Kit
  final List<StoreItem> _stores = const [
    StoreItem(
      id: 'C001',
      name: 'Cửa hàng bánh phường Nhiêu Lộc',
      branchCode: 'C001',
      status: VisitStatus.visited,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '50.00m',
    ),
    StoreItem(
      id: 'C002',
      name: 'Cửa hàng bánh phường An Khánh',
      branchCode: 'C001',
      status: VisitStatus.missed,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '120.00m',
    ),
    StoreItem(
      id: 'C003',
      name: 'Cửa hàng bánh phường Xuân Hòa',
      branchCode: 'C001',
      status: VisitStatus.pending,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '350.00m',
    ),
  ];

  void _openStoreDetail(StoreItem store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => StoreDetailBottomSheet(
        store: store,
        onStartVisit: () {
          Navigator.pop(bottomSheetContext); // Close bottom sheet
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VisitActivitiesScreen(store: store),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Main Content: App Bar & Scrolling Store List
            Column(
              children: [
                _buildSearchAppBar(),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: _stores.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final store = _stores[index];
                      return StoreCard(
                        store: store,
                        onVisitPressed: () => _openStoreDetail(store),
                      );
                    },
                  ),
                ),
                _buildNavigationBar(),
              ],
            ),

            // Design 2: Scrim overlay (when FAB menu is open)
            if (_isFabMenuOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _isFabMenuOpen = false),
                  child: Container(
                    color: AppColors.scrim.withOpacity(0.32),
                  ),
                ),
              ),

            // Design 1 & 2: FAB & Speed Dial Menu
            Positioned(
              right: 16,
              bottom: 96, // Placed right above the navigation bar
              child: FabMenu(
                isOpen: _isFabMenuOpen,
                onToggle: () {
                  setState(() => _isFabMenuOpen = !_isFabMenuOpen);
                },
                onOffRouteVisit: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mở viếng thăm trái tuyến')),
                  );
                },
                onCreateCustomer: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mở tạo khách hàng')),
                  );
                },
                onCreateBranch: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mở tạo chi nhánh')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Material 3 App Bar with Embedded Search Bar
  Widget _buildSearchAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Monogram leading avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Search Field Container
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Search product',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 24,
                    color: AppColors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),

          // Trailing Actions (Filter icon & Profile Avatar)
          IconButton(
            icon: const Icon(
              Icons.tune,
              size: 24,
              color: AppColors.onSurfaceVariant,
            ),
            onPressed: () {},
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Material 3 Vertical items Navigation Bar
  Widget _buildNavigationBar() {
    return Container(
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
          // Navigation Handle
          Container(
            height: 24,
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
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedNavIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedNavIndex = index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 24,
                    color: isSelected ? AppColors.secondary : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: isSelected ? AppColors.secondary : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
