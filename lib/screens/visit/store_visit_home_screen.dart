import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';
import '../../widgets/store_card.dart';
import '../../widgets/fab_menu.dart';
import '../../widgets/store_detail_bottom_sheet.dart';
import '../visit_activities_screen.dart';
import '../schedule/work_schedule_screen.dart';
import 'create_customer_screen.dart';
import 'missed_visit_dialog.dart';

class StoreVisitHomeScreen extends StatefulWidget {
  const StoreVisitHomeScreen({super.key});

  @override
  State<StoreVisitHomeScreen> createState() => _StoreVisitHomeScreenState();
}

class _StoreVisitHomeScreenState extends State<StoreVisitHomeScreen> {
  bool _isFabMenuOpen = false;
  String _selectedFilter = 'Tất cả';
  String _sortBy = 'Khoảng cách';
  String _searchQuery = '';

  // Working store list
  final List<StoreItem> _stores = [
    const StoreItem(
      id: 'C001',
      name: 'Cửa hàng bánh phường Nhiêu Lộc',
      branchCode: 'C001',
      status: VisitStatus.visited,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '50.00m',
    ),
    const StoreItem(
      id: 'C002',
      name: 'Cửa hàng bánh phường An Khánh',
      branchCode: 'C002',
      status: VisitStatus.missed,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '120.00m',
    ),
    const StoreItem(
      id: 'C003',
      name: 'Cửa hàng bánh phường Xuân Hòa',
      branchCode: 'C003',
      status: VisitStatus.pending,
      channel: 'Modern Trade',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '350.00m',
    ),
    const StoreItem(
      id: 'C004',
      name: 'Bách hóa xanh Thị Nghè',
      branchCode: 'C004',
      status: VisitStatus.pending,
      channel: 'Modern Trade',
      customerType: 'Chuỗi bán lẻ',
      paymentMethod: 'Trực tiếp',
      distance: '480.00m',
    ),
    const StoreItem(
      id: 'C005',
      name: 'Tiệm bánh Kim Loan Bùi Thị Xuân',
      branchCode: 'C005',
      status: VisitStatus.pending,
      channel: 'Bakery Shop',
      customerType: 'Người dùng cuối',
      paymentMethod: 'Trực tiếp',
      distance: '620.00m',
    ),
  ];

  void _openStoreDetail(StoreItem store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => StoreDetailBottomSheet(
        store: store,
        onStartVisit: () async {
          Navigator.pop(bottomSheetContext); // Close bottom sheet
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => VisitActivitiesScreen(store: store),
            ),
          );

          if (result == true && mounted) {
            setState(() {
              final idx = _stores.indexWhere((s) => s.id == store.id);
              if (idx != -1) {
                _stores[idx] = StoreItem(
                  id: store.id,
                  name: store.name,
                  branchCode: store.branchCode,
                  status: VisitStatus.visited,
                  channel: store.channel,
                  customerType: store.customerType,
                  paymentMethod: store.paymentMethod,
                  distance: store.distance,
                );
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã hoàn thành viếng thăm: ${store.name}'),
                backgroundColor: VfmColors.primaryGreen,
              ),
            );
          } else if (result == false && mounted) {
            setState(() {
              final idx = _stores.indexWhere((s) => s.id == store.id);
              if (idx != -1) {
                _stores[idx] = StoreItem(
                  id: store.id,
                  name: store.name,
                  branchCode: store.branchCode,
                  status: VisitStatus.missed,
                  channel: store.channel,
                  customerType: store.customerType,
                  paymentMethod: store.paymentMethod,
                  distance: store.distance,
                );
              }
            });
          }
        },
      ),
    );
  }

  void _markMissedVisit(StoreItem store) {
    MissedVisitDialog.show(
      context,
      store: store,
      onSubmit: (reason, note) {
        setState(() {
          final idx = _stores.indexWhere((s) => s.id == store.id);
          if (idx != -1) {
            _stores[idx] = StoreItem(
              id: store.id,
              name: store.name,
              branchCode: store.branchCode,
              status: VisitStatus.missed,
              channel: store.channel,
              customerType: store.customerType,
              paymentMethod: store.paymentMethod,
              distance: store.distance,
            );
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã ghi nhận lý do lỡ thăm viếng: $reason'),
            backgroundColor: const Color(0xFFDC2626),
          ),
        );
      },
    );
  }

  void _navigateCreateCustomer({bool isBranchOnly = false}) async {
    setState(() => _isFabMenuOpen = false);
    final newStore = await Navigator.push<StoreItem>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateCustomerScreen(
          isBranchOnly: isBranchOnly,
          parentStore: isBranchOnly ? _stores.first : null,
        ),
      ),
    );

    if (newStore != null && mounted) {
      setState(() {
        _stores.insert(0, newStore);
      });
    }
  }

  void _recordSpecialWorkMode(String modeName) {
    setState(() => _isFabMenuOpen = false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: VfmColors.primaryGreen),
            const SizedBox(width: 8),
            Text(modeName, style: const TextStyle(fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Text(
          'Đã chuyển trạng thái làm việc hôm nay thành "$modeName". Dữ liệu được đồng bộ về giám sát tuyến (Supervisor).',
          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: VfmColors.primaryGreen, elevation: 0),
            child: const Text('Xác nhận', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<StoreItem> filteredStores = _stores.where((store) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = store.name.toLowerCase().contains(q) || store.branchCode.toLowerCase().contains(q);
        if (!match) return false;
      }

      if (_selectedFilter == 'Đã thăm viếng') {
        return store.status == VisitStatus.visited;
      } else if (_selectedFilter == 'Lỡ viếng thăm') {
        return store.status == VisitStatus.missed;
      } else if (_selectedFilter == 'Chưa thăm viếng') {
        return store.status == VisitStatus.pending;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                _buildSearchAppBar(),
                _buildSortAndFilterBar(),
                Expanded(
                  child: filteredStores.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.store_mall_directory_outlined, size: 56, color: Color(0xFF989799)),
                              SizedBox(height: 12),
                              Text('Không tìm thấy cửa hàng nào', style: TextStyle(color: Color(0xFF6B7280))),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                          itemCount: filteredStores.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final store = filteredStores[index];
                            return StoreCard(
                              store: store,
                              onVisitPressed: () => _openStoreDetail(store),
                            );
                          },
                        ),
                ),
              ],
            ),

            // Scrim overlay
            if (_isFabMenuOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _isFabMenuOpen = false),
                  child: Container(
                    color: AppColors.scrim.withOpacity(0.32),
                  ),
                ),
              ),

            // Speed Dial FAB
            Positioned(
              right: 16,
              bottom: 24,
              child: FabMenu(
                isOpen: _isFabMenuOpen,
                onToggle: () => setState(() => _isFabMenuOpen = !_isFabMenuOpen),
                onOffRouteVisit: () {
                  setState(() => _isFabMenuOpen = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Danh sách khách hàng trái tuyến của Supervisor quản lý')),
                  );
                },
                onCreateCustomer: () => _navigateCreateCustomer(isBranchOnly: false),
                onCreateBranch: () => _navigateCreateCustomer(isBranchOnly: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // Monogram leading avatar
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFD8FFEE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'TÚ',
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: VfmColors.primaryGreen,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Search Field
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEFE8),
                borderRadius: BorderRadius.circular(21),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: const InputDecoration(
                        hintText: 'Tìm cửa hàng, mã chi nhánh...',
                        hintStyle: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const Icon(Icons.search, size: 20, color: Color(0xFF6B7280)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Schedule icon
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, size: 22, color: VfmColors.primaryGreen),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkScheduleScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSortAndFilterBar() {
    final filters = ['Tất cả', 'Chưa thăm viếng', 'Đã thăm viếng', 'Lỡ viếng thăm'];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
      child: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((f) {
                final isSel = _selectedFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: isSel,
                    onSelected: (val) => setState(() => _selectedFilter = f),
                    selectedColor: const Color(0xFFD8FFEE),
                    backgroundColor: const Color(0xFFF3F4F6),
                    labelStyle: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      color: isSel ? VfmColors.primaryGreen : const Color(0xFF4B5563),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 4),

          // Count & Sort row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lộ trình hôm nay: ${_stores.length} điểm bán',
                style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111418)),
              ),
              Row(
                children: [
                  const Icon(Icons.sort, size: 14, color: Color(0xFF6B7280)),
                  const SizedBox(width: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sortBy,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                      style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFF6B7280)),
                      items: const [
                        DropdownMenuItem(value: 'Khoảng cách', child: Text('Khoảng cách')),
                        DropdownMenuItem(value: 'Tên A-Z', child: Text('Tên A-Z')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _sortBy = val);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
