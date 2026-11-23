import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../theme/app_colors.dart';
import '../theme/vfm_colors.dart';
import 'visit/customer_info_detail_screen.dart';
import 'visit/purchase_survey_screen.dart';
import 'visit/flour_demo_screen.dart';
import 'visit/issue_report_screen.dart';
import 'visit/promotions_support_screen.dart';
import 'visit/net_price_screen.dart';
import 'visit/end_visit_summary_screen.dart';

class VisitActivitiesScreen extends StatefulWidget {
  final StoreItem store;

  const VisitActivitiesScreen({
    super.key,
    required this.store,
  });

  @override
  State<VisitActivitiesScreen> createState() => _VisitActivitiesScreenState();
}

class _VisitActivitiesScreenState extends State<VisitActivitiesScreen> {
  final Map<String, bool> _completedMap = {
    'info': true,
    'purchase': true,
    'demo': false,
    'issue': false,
    'promo': true,
    'net_price': true,
  };

  void _navigateToActivity(int index) async {
    switch (index) {
      case 0:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CustomerInfoDetailScreen(store: widget.store)),
        );
        setState(() => _completedMap['info'] = true);
        break;
      case 1:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PurchaseSurveyScreen(store: widget.store)),
        );
        setState(() => _completedMap['purchase'] = true);
        break;
      case 2:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FlourDemoScreen(store: widget.store)),
        );
        setState(() => _completedMap['demo'] = true);
        break;
      case 3:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => IssueReportScreen(store: widget.store)),
        );
        setState(() => _completedMap['issue'] = true);
        break;
      case 4:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PromotionsSupportScreen(store: widget.store)),
        );
        setState(() => _completedMap['promo'] = true);
        break;
      case 5:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NetPriceScreen(store: widget.store)),
        );
        setState(() => _completedMap['net_price'] = true);
        break;
    }
  }

  void _onFinishVisit() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EndVisitSummaryScreen(
          store: widget.store,
          completedActivities: _completedMap,
        ),
      ),
    );

    if (result != null && mounted) {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activities = [
      {'key': 'info', 'title': 'Thông tin khách hàng', 'icon': Icons.person_outline, 'sub': 'Xem & cập nhật hồ sơ tiệm bánh'},
      {'key': 'purchase', 'title': 'Thu thập thông tin mua hàng', 'icon': Icons.shopping_bag_outlined, 'sub': 'Ghi nhận đơn đặt hàng & sản lượng'},
      {'key': 'demo', 'title': 'Demo và thử bột', 'icon': Icons.bakery_dining_outlined, 'sub': 'Đánh giá chất lượng nướng bánh thực tế'},
      {'key': 'issue', 'title': 'Hoạt động xử lý sự cố', 'icon': Icons.report_problem_outlined, 'sub': 'Báo cáo sự cố bột hoặc kỹ thuật lò'},
      {'key': 'promo', 'title': 'Chương trình hỗ trợ bán hàng', 'icon': Icons.card_giftcard_outlined, 'sub': 'Biển hiệu, khay nướng, khuyến mãi'},
      {'key': 'net_price', 'title': 'Thu thập thông tin giá NET', 'icon': Icons.price_check_outlined, 'sub': 'Khảo sát giá thị trường & đối thủ'},
    ];

    int completedCount = _completedMap.values.where((v) => v).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111418)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hoạt động thăm viếng',
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Store Quick Context Card
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8FFEE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.storefront, color: VfmColors.primaryGreen, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.store.name,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111418),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Mã: ${widget.store.branchCode} • ${widget.store.channel}',
                          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8FFEE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$completedCount/6 xong',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: VfmColors.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Activities List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: activities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final act = activities[index];
                  final isDone = _completedMap[act['key']] ?? false;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDone ? VfmColors.primaryGreen.withOpacity(0.4) : const Color(0xFFD1D8DB),
                      ),
                      boxShadow: const [
                        BoxShadow(color: Color(0x06000000), offset: Offset(0, 1), blurRadius: 3),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _navigateToActivity(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: isDone ? const Color(0xFFD8FFEE) : const Color(0xFFF3F3F3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  act['icon'] as IconData,
                                  color: isDone ? VfmColors.primaryGreen : const Color(0xFF6B7280),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      act['title'] as String,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDone ? const Color(0xFF111418) : const Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      act['sub'] as String,
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isDone ? const Color(0xFFD8FFEE) : const Color(0xFFF3F3F3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  isDone ? 'Đã làm' : 'Chưa làm',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isDone ? VfmColors.primaryGreen : const Color(0xFF989799),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.chevron_right, size: 20, color: Color(0xFF6B7280)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onFinishVisit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VfmColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kết thúc viếng thăm',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
