import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class RequestItem {
  final String requestCode;
  final String requestType; // 'Sự cố kỹ thuật' | 'Demo mẫu bột' | 'Khảo sát giá NET'
  final String customerName;
  final String content;
  final DateTime createdDate;
  String status; // 'Chờ duyệt' | 'Đã duyệt' | 'Từ chối'
  String? rejectionReason;

  RequestItem({
    required this.requestCode,
    required this.requestType,
    required this.customerName,
    required this.content,
    required this.createdDate,
    required this.status,
    this.rejectionReason,
  });
}

class _RequestsScreenState extends State<RequestsScreen> {
  int _selectedFilterIndex = 0; // 0: Tất cả, 1: Chờ duyệt, 2: Đã duyệt, 3: Từ chối
  String _selectedCategory = 'Tất cả';

  final List<RequestItem> _allRequests = [
    RequestItem(
      requestCode: 'YC-SC-081',
      requestType: 'Sự cố kỹ thuật',
      customerName: 'Cửa hàng bánh phường Nhiêu Lộc',
      content: 'Bột nướng bánh mì không bung cánh, đề xuất đổi 2 bao và cử KTV hỗ trợ',
      createdDate: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Chờ duyệt',
    ),
    RequestItem(
      requestCode: 'YC-DM-042',
      requestType: 'Demo mẫu bột',
      customerName: 'Cửa hàng bánh phường An Khánh',
      content: 'Cung cấp 5kg bột Baker’s Choice Số 13 để làm thử bánh mì Sandwich cao cấp',
      createdDate: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Đã duyệt',
    ),
    RequestItem(
      requestCode: 'YC-PR-019',
      requestType: 'Khảo sát giá NET',
      customerName: 'Cửa hàng bánh phường Xuân Hòa',
      content: 'Bột mì Bình Đông đang áp dụng giảm giá 15k/bao, xin duyệt chính sách quà tặng kèm',
      createdDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Từ chối',
      rejectionReason: 'Chính sách chiết khấu hiện tại của chi nhánh đã đạt trần tối đa theo quy định Q3',
    ),
    RequestItem(
      requestCode: 'YC-DM-045',
      requestType: 'Demo mẫu bột',
      customerName: 'Tiệm bánh Kim Loan Quận 1',
      content: 'Thử mẫu bột bánh bông lan Baker’s Choice Số 8 cho xưởng bánh sinh nhật',
      createdDate: DateTime.now().subtract(const Duration(hours: 4)),
      status: 'Chờ duyệt',
    ),
  ];

  void _showRejectionDetail(RequestItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.cancel_outlined, color: VfmColors.error, size: 24),
                SizedBox(width: 8),
                Text(
                  'Lý do từ chối yêu cầu',
                  style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20),
            Text('Mã yêu cầu: ${item.requestCode}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Khách hàng: ${item.customerName}', style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFDC2626).withOpacity(0.3)),
              ),
              child: Text(
                item.rejectionReason ?? 'Yêu cầu chưa đáp ứng điều kiện phê duyệt của giám sát kinh doanh.',
                style: const TextStyle(color: Color(0xFF991B1B), fontSize: 13, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: VfmColors.primaryGreen,
                  elevation: 0,
                ),
                child: const Text('Đã hiểu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<RequestItem> filtered = _allRequests;
    if (_selectedFilterIndex == 1) {
      filtered = filtered.where((r) => r.status == 'Chờ duyệt').toList();
    } else if (_selectedFilterIndex == 2) {
      filtered = filtered.where((r) => r.status == 'Đã duyệt').toList();
    } else if (_selectedFilterIndex == 3) {
      filtered = filtered.where((r) => r.status == 'Từ chối').toList();
    }

    if (_selectedCategory != 'Tất cả') {
      filtered = filtered.where((r) => r.requestType == _selectedCategory).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Quản lý yêu cầu & Phê duyệt',
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status Tabs
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  _buildTabItem(0, 'Tất cả'),
                  _buildTabItem(1, 'Chờ duyệt'),
                  _buildTabItem(2, 'Đã duyệt'),
                  _buildTabItem(3, 'Từ chối'),
                ],
              ),
            ),
            const Divider(height: 1),

            // Category Chips
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['Tất cả', 'Sự cố kỹ thuật', 'Demo mẫu bột', 'Khảo sát giá NET'].map((cat) {
                    final isSel = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(cat),
                        selected: isSel,
                        onSelected: (val) => setState(() => _selectedCategory = cat),
                        backgroundColor: const Color(0xFFF3F4F6),
                        selectedColor: const Color(0xFFD8FFEE),
                        checkmarkColor: VfmColors.primaryGreen,
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
            ),

            // Requests List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.assignment_turned_in_outlined, size: 56, color: Color(0xFF989799)),
                          SizedBox(height: 12),
                          Text('Không có yêu cầu nào trong danh mục này', style: TextStyle(color: Color(0xFF6B7280))),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, index) {
                        final item = filtered[index];
                        return _buildRequestCard(item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    final isSelected = _selectedFilterIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedFilterIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? VfmColors.primaryGreen : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? VfmColors.primaryGreen : const Color(0xFF6B7280),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(RequestItem item) {
    Color statusBg = const Color(0xFFFFF3D6);
    Color statusText = const Color(0xFFB45309);

    if (item.status == 'Đã duyệt') {
      statusBg = const Color(0xFFD8FFEE);
      statusText = VfmColors.primaryGreen;
    } else if (item.status == 'Từ chối') {
      statusBg = const Color(0xFFFEE2E2);
      statusText = const Color(0xFFDC2626);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D8DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.requestCode,
                style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: VfmColors.primaryGreen),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusText),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            item.customerName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111418)),
          ),
          const SizedBox(height: 2),
          Text(
            'Loại: ${item.requestType} • ${item.createdDate.day}/${item.createdDate.month}/${item.createdDate.year}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 8),
          Text(
            item.content,
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.3),
          ),
          if (item.status == 'Từ chối') ...[
            const Divider(height: 16),
            InkWell(
              onTap: () => _showRejectionDetail(item),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, size: 14, color: Color(0xFFDC2626)),
                  SizedBox(width: 6),
                  Text(
                    'Xem lý do từ chối của cấp quản lý',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFDC2626), decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
