import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'Tháng này (08/2026)';

  final List<Map<String, dynamic>> _reportItems = [
    {
      'title': 'BC thông tin kinh doanh khách hàng',
      'sub': 'Theo dõi doanh thu, lịch sử mua và công nợ từng lò bánh',
      'icon': Icons.storefront,
      'color': Color(0xFF006638),
      'stat': '124 tiệm bánh',
    },
    {
      'title': 'BC số lượng khách hàng theo vùng',
      'sub': 'Phân bố điểm bán tại TP.HCM, Bình Dương, Đồng Nai',
      'icon': Icons.pie_chart_outline,
      'color': Color(0xFF2563EB),
      'stat': '3 phân vùng',
    },
    {
      'title': 'BC tổng sản lượng theo phân vùng',
      'sub': 'Tỷ trọng tiêu thụ bột Baker’s Choice, Hoa Ngọc Lan',
      'icon': Icons.bar_chart,
      'color': Color(0xFFD97706),
      'stat': '48.5 tấn',
    },
    {
      'title': 'BC vị trí khách hàng (Bản đồ GPS)',
      'sub': 'Trực quan hóa mạng lưới tiệm bánh trên bản đồ số',
      'icon': Icons.map_outlined,
      'color': Color(0xFF059669),
      'stat': '100% tọa độ',
    },
    {
      'title': 'Báo cáo bán hàng hàng tuần',
      'sub': 'Tổng hợp số đơn, tiến độ KPI và độ phủ tuyến viếng thăm',
      'icon': Icons.calendar_view_week,
      'color': Color(0xFF7C3AED),
      'stat': 'Tuần 34',
    },
    {
      'title': 'Báo cáo hỗ trợ kỹ thuật Bakery',
      'sub': 'Thống kê kết quả demo thử bột và khắc phục sự cố nướng bánh',
      'icon': Icons.build_circle_outlined,
      'color': Color(0xFFDC2626),
      'stat': '8 ca hỗ trợ',
    },
    {
      'title': 'BC chi phí & công tác phí',
      'sub': 'Xăng xe, phụ cấp thị trường và tiếp khách được phê duyệt',
      'icon': Icons.receipt_long,
      'color': Color(0xFF4B5563),
      'stat': '4,250,000 đ',
    },
  ];

  void _openReportDetail(String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              children: [
                const Icon(Icons.analytics, color: VfmColors.primaryGreen, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(height: 20),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFF6FBF3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD1D8DB)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.insert_chart_outlined, size: 48, color: VfmColors.primaryGreen),
                    SizedBox(height: 8),
                    Text(
                      'Biểu đồ thống kê số liệu chi tiết',
                      style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D6A44)),
                    ),
                    Text(
                      'Dữ liệu đồng bộ trực tiếp từ hệ thống SAP VFM',
                      style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đang xuất báo cáo định dạng Excel / PDF...')),
                      );
                    },
                    icon: const Icon(Icons.download, size: 16, color: VfmColors.primaryGreen),
                    label: const Text('Tải file Excel', style: TextStyle(color: VfmColors.primaryGreen, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: VfmColors.primaryGreen)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(backgroundColor: VfmColors.primaryGreen, elevation: 0),
                    child: const Text('Đóng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Báo cáo & Phân tích',
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: VfmColors.primaryGreen),
            onSelected: (val) => setState(() => _selectedPeriod = val),
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'Tuần này', child: Text('Tuần này')),
              const PopupMenuItem(value: 'Tháng này (08/2026)', child: Text('Tháng này (08/2026)')),
              const PopupMenuItem(value: 'Quý 3/2026', child: Text('Quý 3/2026')),
              const PopupMenuItem(value: 'Năm 2026', child: Text('Năm 2026')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Period tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kỳ báo cáo: $_selectedPeriod',
                    style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
                  ),
                  const Text(
                    'Cập nhật: Hôm nay',
                    style: TextStyle(fontSize: 12, color: Color(0xFF989799)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Highlight KPIs row
              Row(
                children: [
                  Expanded(
                    child: _buildKpiCard('Sản lượng tháng', '48.5 tấn', '+12.4%', true, Icons.scale),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard('Tỷ lệ viếng thăm', '92.0%', '46/50 KH', true, Icons.check_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildKpiCard('Doanh số đạt', '820 tr', '96% KPI', true, Icons.monetization_on_outlined),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard('Sự cố kỹ thuật', '5/5', '100% xử lý', true, Icons.build_circle_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Category Reports Section
              const Text(
                'Danh mục báo cáo quản trị',
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111418),
                ),
              ),
              const SizedBox(height: 10),

              ..._reportItems.map((rep) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD1D8DB)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (rep['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(rep['icon'] as IconData, color: rep['color'] as Color, size: 22),
                    ),
                    title: Text(
                      rep['title'] as String,
                      style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111418)),
                    ),
                    subtitle: Text(
                      rep['sub'] as String,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            rep['stat'] as String,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 18, color: Color(0xFF989799)),
                      ],
                    ),
                    onTap: () => _openReportDetail(rep['title'] as String),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, String sub, bool isPositive, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
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
              Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              Icon(icon, size: 16, color: VfmColors.primaryGreen),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111418),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: isPositive ? VfmColors.primaryGreen : VfmColors.error,
              ),
              const SizedBox(width: 4),
              Text(
                sub,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? VfmColors.primaryGreen : VfmColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
