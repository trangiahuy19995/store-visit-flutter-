import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class FlourDemoScreen extends StatefulWidget {
  final StoreItem store;

  const FlourDemoScreen({super.key, required this.store});

  @override
  State<FlourDemoScreen> createState() => _FlourDemoScreenState();
}

class DemoItemRecord {
  final String sampleFlourName;
  final String bakeryProduct;
  final double sampleWeightKg;
  final String waterAbsorption;
  final String ovenSpring; // Độ nở lò
  final String crumbStructure; // Cấu trúc ruột
  final String crustCrispiness; // Độ giòn vỏ
  final String bakerFeedback;
  final DateTime testDate;
  final String status;

  DemoItemRecord({
    required this.sampleFlourName,
    required this.bakeryProduct,
    required this.sampleWeightKg,
    required this.waterAbsorption,
    required this.ovenSpring,
    required this.crumbStructure,
    required this.crustCrispiness,
    required this.bakerFeedback,
    required this.testDate,
    required this.status,
  });
}

class _FlourDemoScreenState extends State<FlourDemoScreen> {
  final List<DemoItemRecord> _demoList = [
    DemoItemRecord(
      sampleFlourName: "Baker's Choice Số 11 Cải tiến (High Protein)",
      bakeryProduct: 'Bánh mì Baguette Việt Nam',
      sampleWeightKg: 5.0,
      waterAbsorption: '62%',
      ovenSpring: 'Rất tốt (+15% so với bột cũ)',
      crumbStructure: 'Ruột xốp thoáng, thớ dai mềm',
      crustCrispiness: 'Vỏ mỏng vàng rơm, giòn lâu 4 tiếng',
      bakerFeedback: 'Thợ trưởng rất ưng ý, muốn đặt ngay 10 bao tuần tới',
      testDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Hài lòng - Sẵn sàng chốt',
    ),
  ];

  void _openCreateDemoDialog() {
    String flourName = "Baker's Choice Số 11 Cải tiến";
    String bakeryType = 'Bánh mì Baguette';
    final weightCtrl = TextEditingController(text: '5.0');
    final feedbackCtrl = TextEditingController();
    String ovenSpring = 'Rất tốt';
    String crumb = 'Xốp thoáng & dai mềm';
    String crust = 'Vàng rơm, giòn lâu';

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
                        'Ghi nhận kết quả demo / Thử bột',
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

                  // Flour name
                  const Text('Dòng bột mẫu thử nghiệm *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: flourName,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "Baker's Choice Số 11 Cải tiến", child: Text("Baker's Choice Số 11 Cải tiến")),
                          DropdownMenuItem(value: "Baker's Choice Số 13 Cao Cấp", child: Text("Baker's Choice Số 13 Cao Cấp")),
                          DropdownMenuItem(value: "Bột mì Hoa Ngọc Lan Chuyên Dụng", child: Text("Bột mì Hoa Ngọc Lan Chuyên Dụng")),
                          DropdownMenuItem(value: "Bột làm bánh ngọt / Sponge Cake", child: Text("Bột làm bánh ngọt / Sponge Cake")),
                          DropdownMenuItem(value: "Bột lúa mạch đen / Whole Wheat", child: Text("Bột lúa mạch đen / Whole Wheat")),
                        ],
                        onChanged: (v) => setMState(() => flourName = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Product & Weight
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sản phẩm nướng thử', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFD1D8DB)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: bakeryType,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'Bánh mì Baguette', child: Text('Bánh mì Baguette')),
                                    DropdownMenuItem(value: 'Bánh mì gối Sandwich', child: Text('Bánh mì Sandwich')),
                                    DropdownMenuItem(value: 'Bánh bao hấp', child: Text('Bánh bao hấp')),
                                    DropdownMenuItem(value: 'Bánh bông lan nướng', child: Text('Bánh bông lan')),
                                  ],
                                  onChanged: (v) => setMState(() => bakeryType = v!),
                                ),
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
                            const Text('Khối lượng mẫu (kg)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: weightCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Technical outcomes
                  const Text('Độ nở lò nướng (Oven Spring)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: ovenSpring,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'Rất tốt', child: Text('Rất tốt - Bung cánh đẹp')),
                          DropdownMenuItem(value: 'Khá tốt', child: Text('Khá tốt - Đạt chuẩn')),
                          DropdownMenuItem(value: 'Trung bình', child: Text('Trung bình - Chưa nở hết cỡ')),
                        ],
                        onChanged: (v) => setMState(() => ovenSpring = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Ruột & Vỏ
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cấu trúc ruột bánh', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: TextEditingController(text: crumb),
                              onChanged: (v) => crumb = v,
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
                            const Text('Màu sắc & độ giòn vỏ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: TextEditingController(text: crust),
                              onChanged: (v) => crust = v,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Baker Feedback
                  const Text('Ý kiến & đánh giá của khách hàng', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: feedbackCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Nhập nhận xét của chủ tiệm hoặc thợ làm bánh...',
                      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF989799)),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      final weight = double.tryParse(weightCtrl.text) ?? 5.0;
                      final record = DemoItemRecord(
                        sampleFlourName: flourName,
                        bakeryProduct: bakeryType,
                        sampleWeightKg: weight,
                        waterAbsorption: '63%',
                        ovenSpring: ovenSpring,
                        crumbStructure: crumb,
                        crustCrispiness: crust,
                        bakerFeedback: feedbackCtrl.text.trim().isNotEmpty
                            ? feedbackCtrl.text.trim()
                            : 'Khách hàng đánh giá tốt về chất lượng nướng',
                        testDate: DateTime.now(),
                        status: 'Đã hoàn thành thử mẫu',
                      );
                      setState(() {
                        _demoList.insert(0, record);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã ghi nhận kết quả thử bột thành công!'),
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
                      'Lưu kết quả thử nghiệm',
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
          'Demo và thử bột',
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
                  const Icon(Icons.cake, color: VfmColors.primaryGreen, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.store.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_demoList.length} đợt demo',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: _demoList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.science_outlined, size: 56, color: Color(0xFF989799)),
                          SizedBox(height: 12),
                          Text('Chưa có lịch sử demo thử mẫu nào', style: TextStyle(color: Color(0xFF6B7280))),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _demoList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, index) {
                        final item = _demoList[index];
                        return _buildDemoCard(item);
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
                  onPressed: _openCreateDemoDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Ghi nhận kết quả demo mới',
                    style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VfmColors.primaryGreen,
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

  Widget _buildDemoCard(DemoItemRecord item) {
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
              Expanded(
                child: Text(
                  item.sampleFlourName,
                  style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111418)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD8FFEE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.status,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: VfmColors.primaryGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.bakery_dining_outlined, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 4),
              Text(
                'Làm thử: ${item.bakeryProduct}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                'Lượng mẫu: ${item.sampleWeightKg} kg',
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const Divider(height: 16),
          _buildOutcomeRow('Độ nở lò', item.ovenSpring),
          _buildOutcomeRow('Cấu trúc ruột', item.crumbStructure),
          _buildOutcomeRow('Màu & vỏ bánh', item.crustCrispiness),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FBF3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.comment, size: 14, color: VfmColors.primaryGreen),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.bakerFeedback,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF111418), fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutcomeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111418))),
          ),
        ],
      ),
    );
  }
}
