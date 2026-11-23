import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class IssueReportScreen extends StatefulWidget {
  final StoreItem store;

  const IssueReportScreen({super.key, required this.store});

  @override
  State<IssueReportScreen> createState() => _IssueReportScreenState();
}

class IssueItemRecord {
  final String issueCode;
  final String productName;
  final String batchNo;
  final String issueCategory;
  final String severity;
  final String description;
  final String resolutionProposal;
  final DateTime reportedDate;
  final String status;

  IssueItemRecord({
    required this.issueCode,
    required this.productName,
    required this.batchNo,
    required this.issueCategory,
    required this.severity,
    required this.description,
    required this.resolutionProposal,
    required this.reportedDate,
    required this.status,
  });
}

class _IssueReportScreenState extends State<IssueReportScreen> {
  final List<IssueItemRecord> _issues = [
    IssueItemRecord(
      issueCode: 'SC-2026-081',
      productName: "Baker's Choice Số 11",
      batchNo: 'LOT-260815-A',
      issueCategory: 'Bánh nướng độ nở kém',
      severity: 'Trung bình',
      description: 'Lò nướng nhiệt độ 220 độ C nhưng bánh bung cánh không đều, bột bị dẻo quá mức',
      resolutionProposal: 'Cử Kỹ thuật viên Bakery VFM đến chỉnh thời gian ủ bột & kiểm tra độ ẩm',
      reportedDate: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Đang xử lý',
    ),
  ];

  void _openCreateIssueDialog() {
    String productName = "Baker's Choice Số 11";
    final batchCtrl = TextEditingController(text: 'LOT-260823-B');
    String category = 'Bánh nướng bung cánh kém';
    String severity = 'Trung bình';
    final descCtrl = TextEditingController();
    final propCtrl = TextEditingController(text: 'Đổi trả bao mới & cử KTV kiểm tra');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setMState) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Báo cáo sự cố kỹ thuật bột bánh',
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111418),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),

                  const Text('Sản phẩm phát sinh sự cố *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: productName,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Baker's Choice Số 11", child: Text("Baker's Choice Số 11")),
                          DropdownMenuItem(value: "Baker's Choice Số 13", child: Text("Baker's Choice Số 13")),
                          DropdownMenuItem(value: "Baker's Choice Số 8", child: Text("Baker's Choice Số 8")),
                          DropdownMenuItem(value: 'Bột mì Hoa Ngọc Lan', child: Text('Bột mì Hoa Ngọc Lan')),
                          DropdownMenuItem(value: 'Bột mì Meizan', child: Text('Bột mì Meizan')),
                        ],
                        onChanged: (v) => setMState(() => productName = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mã số lô hàng (Lot/Batch)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: batchCtrl,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mức độ ưu tiên', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFD1D8DB)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: severity,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'Khẩn cấp', child: Text('Khẩn cấp')),
                                    DropdownMenuItem(value: 'Trung bình', child: Text('Trung bình')),
                                    DropdownMenuItem(value: 'Thấp', child: Text('Thấp')),
                                  ],
                                  onChanged: (v) => setMState(() => severity = v!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const Text('Phân loại sự cố *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: category,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'Bánh nướng bung cánh kém', child: Text('Bánh nướng bung cánh kém')),
                          DropdownMenuItem(value: 'Bột bị vón cục / ẩm', child: Text('Bột bị vón cục / ẩm')),
                          DropdownMenuItem(value: 'Ruột bánh bị dai / chua', child: Text('Ruột bánh bị dai / chua')),
                          DropdownMenuItem(value: 'Bao bì rách / lem nhãn', child: Text('Bao bì rách / lem nhãn')),
                          DropdownMenuItem(value: 'Vấn đề côn trùng / mọt', child: Text('Vấn đề côn trùng / mọt')),
                        ],
                        onChanged: (v) => setMState(() => category = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Mô tả chi tiết sự cố tại lò', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Nhập hiện trạng bánh hoặc bột tại lò...',
                      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF989799)),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Đề xuất hướng xử lý cho khách hàng', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: propCtrl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Photo proof upload placeholder
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FBF3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt, color: VfmColors.primaryGreen),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Ảnh chụp thực tế bánh/lô bột (1 ảnh đính kèm)',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: VfmColors.primaryGreen),
                          ),
                          child: const Text('Đã chụp', style: TextStyle(fontSize: 11, color: VfmColors.primaryGreen, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      final newIssue = IssueItemRecord(
                        issueCode: 'SC-2026-${DateTime.now().millisecond}',
                        productName: productName,
                        batchNo: batchCtrl.text.trim(),
                        issueCategory: category,
                        severity: severity,
                        description: descCtrl.text.trim().isNotEmpty ? descCtrl.text.trim() : 'Bột bị ảnh hưởng chất lượng nướng',
                        resolutionProposal: propCtrl.text.trim(),
                        reportedDate: DateTime.now(),
                        status: 'Chờ duyệt xử lý',
                      );
                      setState(() {
                        _issues.insert(0, newIssue);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã gửi báo cáo sự cố thành công! Bộ phận kỹ thuật sẽ liên hệ.'),
                          backgroundColor: VfmColors.primaryGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VfmColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Gửi báo cáo sự cố',
                      style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Xử lý sự cố kỹ thuật',
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
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.report_problem_outlined, color: VfmColors.error, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.store.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_issues.length} sự cố',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: _issues.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle_outline, size: 56, color: VfmColors.primaryGreen),
                          SizedBox(height: 12),
                          Text('Không có sự cố nào được ghi nhận', style: TextStyle(color: Color(0xFF6B7280))),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _issues.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, index) {
                        final item = _issues[index];
                        return _buildIssueCard(item);
                      },
                    ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _openCreateIssueDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Tạo báo cáo sự cố mới',
                    style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VfmColors.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(IssueItemRecord item) {
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
                item.issueCode,
                style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: VfmColors.primaryGreen),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: item.status == 'Đang xử lý' ? const Color(0xFFFFF3D6) : const Color(0xFFD8FFEE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: item.status == 'Đang xử lý' ? const Color(0xFFB45309) : VfmColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${item.productName} • Lô: ${item.batchNo}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111418)),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.issueCategory,
                  style: const TextStyle(fontSize: 11, color: Color(0xFFDC2626), fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Mức độ: ${item.severity}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
          ),
          const Divider(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.build_outlined, size: 14, color: VfmColors.primaryGreen),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Đề xuất: ${item.resolutionProposal}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF2D6A44)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
