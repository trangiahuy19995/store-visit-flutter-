import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class PromotionsSupportScreen extends StatefulWidget {
  final StoreItem store;

  const PromotionsSupportScreen({super.key, required this.store});

  @override
  State<PromotionsSupportScreen> createState() => _PromotionsSupportScreenState();
}

class SupportProgramItem {
  final String title;
  final String category;
  final String condition;
  final String benefit;
  final String status;
  bool isRegistered;

  SupportProgramItem({
    required this.title,
    required this.category,
    required this.condition,
    required this.benefit,
    required this.status,
    this.isRegistered = false,
  });
}

class _PromotionsSupportScreenState extends State<PromotionsSupportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<SupportProgramItem> _supportPrograms = [
    SupportProgramItem(
      title: 'Tài trợ bảng hiệu tiệm bánh VFM Bakery 2026',
      category: 'Hỗ trợ hình ảnh & Biển hiệu',
      condition: 'Sản lượng đạt tối thiểu 3 tấn/tháng trong 6 tháng',
      benefit: 'Tài trợ 100% chi phí thiết kế và thi công bảng Alu chữ nổi',
      status: 'Đang triển khai',
      isRegistered: true,
    ),
    SupportProgramItem(
      title: 'Tặng bộ 20 khay nướng bánh mì gợn sóng inox 304',
      category: 'Vật phẩm hỗ trợ lò nướng',
      condition: 'Nhập đơn hàng từ 50 bao Baker’s Choice Số 11',
      benefit: 'Bộ 20 khay nướng tiêu chuẩn Châu Âu trị giá 4,000,000đ',
      status: 'Chưa đăng ký',
      isRegistered: false,
    ),
    SupportProgramItem(
      title: 'Kệ trưng bày bao bột và bánh thành phẩm',
      category: 'Trưng bày điểm bán',
      condition: 'Khách hàng có mặt bằng cửa hàng tối thiểu 30m2',
      benefit: 'Kệ sắt sơn tĩnh điện cao cấp mang thương hiệu Baker’s Choice',
      status: 'Chưa đăng ký',
      isRegistered: false,
    ),
  ];

  final List<Map<String, String>> _campaigns = [
    {
      'title': 'CTKM Mùa Trung Thu 2026: Đặt bột sớm - Rinh vàng 9999',
      'period': '01/08/2026 - 30/09/2026',
      'detail': 'Chiết khấu thêm 15,000đ/bao và cơ hội bốc thăm chỉ vàng 9999 cho các tiệm bánh gia truyền',
      'shared': 'Đã truyền thông trực tiếp cho chủ lò',
    },
    {
      'title': 'Chính sách chiết khấu lũy tiến Q3/2026',
      'period': '01/07/2026 - 30/09/2026',
      'detail': 'Đạt mốc 10 tấn/tháng thưởng thêm 2.5% doanh số',
      'shared': 'Đã gửi file PDF qua Zalo khách hàng',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Chương trình hỗ trợ & Khuyến mãi',
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111418)),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: VfmColors.primaryGreen,
          unselectedLabelColor: const Color(0xFF6B7280),
          indicatorColor: VfmColors.primaryGreen,
          labelStyle: const TextStyle(fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'Ghi nhận hỗ trợ'),
            Tab(text: 'Truyền thông CTKM'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildSupportTab(),
            _buildCampaignTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD8FFEE),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: VfmColors.primaryGreen.withOpacity(0.3)),
          ),
          child: Row(
            children: const [
              Icon(Icons.card_giftcard, color: VfmColors.primaryGreen, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Các gói hỗ trợ phát triển thương hiệu tiệm bánh đồng hành cùng VFM',
                  style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, color: Color(0xFF11512E), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        ..._supportPrograms.map((item) => _buildSupportCard(item)),
      ],
    );
  }

  Widget _buildSupportCard(SupportProgramItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111418)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: item.isRegistered ? const Color(0xFFD8FFEE) : const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.isRegistered ? 'Đã duyệt hỗ trợ' : 'Chưa áp dụng',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: item.isRegistered ? VfmColors.primaryGreen : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Phân loại: ${item.category}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Điều kiện: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111418))),
              Expanded(
                child: Text(item.condition, style: const TextStyle(fontSize: 12, color: Color(0xFF333333))),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quyền lợi: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: VfmColors.primaryGreen)),
              Expanded(
                child: Text(item.benefit, style: const TextStyle(fontSize: 12, color: Color(0xFF2D6A44), fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    item.isRegistered = !item.isRegistered;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(item.isRegistered
                          ? 'Đã đăng ký chương trình "${item.title}" thành công!'
                          : 'Đã hủy đăng ký chương trình.'),
                      backgroundColor: VfmColors.primaryGreen,
                    ),
                  );
                },
                icon: Icon(item.isRegistered ? Icons.check : Icons.add_task, size: 16, color: Colors.white),
                label: Text(
                  item.isRegistered ? 'Đang thực hiện' : 'Đăng ký hỗ trợ',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.isRegistered ? const Color(0xFF4F6353) : VfmColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(80, 32),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ..._campaigns.map((camp) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.campaign, color: Color(0xFFFFB800), size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        camp['title']!,
                        style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111418)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: Color(0xFF6B7280)),
                    const SizedBox(width: 4),
                    Text(
                      'Thời hạn: ${camp['period']}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  camp['detail']!,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
                ),
                const Divider(height: 16),
                Row(
                  children: [
                    const Icon(Icons.verified, size: 14, color: VfmColors.primaryGreen),
                    const SizedBox(width: 6),
                    Text(
                      camp['shared']!,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: VfmColors.primaryGreen),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
