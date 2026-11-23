import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';
import 'missed_visit_dialog.dart';

class EndVisitSummaryScreen extends StatefulWidget {
  final StoreItem store;
  final Map<String, bool> completedActivities;

  const EndVisitSummaryScreen({
    super.key,
    required this.store,
    required this.completedActivities,
  });

  @override
  State<EndVisitSummaryScreen> createState() => _EndVisitSummaryScreenState();
}

class _EndVisitSummaryScreenState extends State<EndVisitSummaryScreen> {
  final _summaryNoteCtrl = TextEditingController(text: 'Khách hàng hài lòng, đã chốt đơn 40 bao Baker’s Choice Số 11');

  @override
  void dispose() {
    _summaryNoteCtrl.dispose();
    super.dispose();
  }

  void _finishVisit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: VfmColors.primaryGreen, size: 28),
            SizedBox(width: 8),
            Text('Hoàn tất thăm viếng', style: TextStyle(fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'Buổi viếng thăm cửa hàng "${widget.store.name}" đã được ghi nhận thành công lên hệ thống!',
          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              Navigator.pop(context, true); // Pop summary screen with true (visited)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: VfmColors.primaryGreen,
              elevation: 0,
            ),
            child: const Text('Về danh sách tuyến đi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _markMissed() {
    MissedVisitDialog.show(
      context,
      store: widget.store,
      onSubmit: (reason, note) {
        Navigator.pop(context, false); // Return to home marked as missed
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = widget.completedActivities.values.where((v) => v).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Kết thúc thăm viếng',
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Store Card from Figma 273:9942
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111418),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Mã chi nhánh: ${widget.store.branchCode}',
                                style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, color: Color(0xFF6B7280)),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Chủ nhật, ngày 23 tháng 8 năm 2026 / 8:00 sáng',
                                style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFF989799)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow('Kênh', widget.store.channel),
                    _buildInfoRow('Loại khách hàng', widget.store.customerType),
                    _buildInfoRow('Phương thức mua bán', widget.store.paymentMethod),
                    _buildInfoRow('Khoảng cách GPS', widget.store.distance),
                    const SizedBox(height: 12),

                    // Map Container
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEFE8),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD1D8DB)),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.location_on, color: VfmColors.primaryGreen),
                                SizedBox(width: 6),
                                Text(
                                  'Định vị GPS chuẩn (Cách 50.00m)',
                                  style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D6A44)),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Mở Google Maps chỉ đường')),
                                );
                              },
                              icon: const Icon(Icons.directions, size: 14, color: VfmColors.primaryGreen),
                              label: const Text('Mở Google Map', style: TextStyle(fontSize: 11, color: VfmColors.primaryGreen, fontWeight: FontWeight.w600)),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: VfmColors.primaryGreen),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                minimumSize: const Size(60, 28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Activity checklist summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tiến độ 6 hoạt động thăm viếng',
                          style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8FFEE),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$completedCount/6 hoàn tất',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: VfmColors.primaryGreen),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 18),
                    _buildActivityCheckRow('1. Cập nhật thông tin khách hàng', widget.completedActivities['info'] ?? true),
                    _buildActivityCheckRow('2. Thu thập thông tin mua hàng', widget.completedActivities['purchase'] ?? true),
                    _buildActivityCheckRow('3. Demo và thử bột tại lò', widget.completedActivities['demo'] ?? false),
                    _buildActivityCheckRow('4. Xử lý sự cố kỹ thuật chất lượng', widget.completedActivities['issue'] ?? false),
                    _buildActivityCheckRow('5. Chương trình hỗ trợ & Khuyến mãi', widget.completedActivities['promo'] ?? true),
                    _buildActivityCheckRow('6. Thu thập thông tin giá NET', widget.completedActivities['net_price'] ?? true),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Note Field
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ghi chú tổng kết của Nhân viên bán hàng',
                      style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _summaryNoteCtrl,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Nhập tóm tắt buổi gặp gỡ, đơn hàng, phản hồi...',
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Actions
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _finishVisit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VfmColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kết thúc thăm viếng',
                    style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  onPressed: _markMissed,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text(
                    'Lỡ thăm viếng',
                    style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFDC2626)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, color: Color(0xFF6B7280))),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111418))),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCheckRow(String title, bool done) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: done ? VfmColors.primaryGreen : const Color(0xFF989799),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 13,
                fontWeight: done ? FontWeight.w600 : FontWeight.normal,
                color: done ? const Color(0xFF111418) : const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
