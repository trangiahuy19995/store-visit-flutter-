import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class NetPriceScreen extends StatefulWidget {
  final StoreItem store;

  const NetPriceScreen({super.key, required this.store});

  @override
  State<NetPriceScreen> createState() => _NetPriceScreenState();
}

class NetPriceSurveyItem {
  final String brandName;
  final String productName;
  final String packaging;
  final double wholesalePriceNet;
  final double retailPriceToBakery;
  final double discountPercent;
  final String competitorPromo;
  final DateTime surveyDate;

  NetPriceSurveyItem({
    required this.brandName,
    required this.productName,
    required this.packaging,
    required this.wholesalePriceNet,
    required this.retailPriceToBakery,
    required this.discountPercent,
    required this.competitorPromo,
    required this.surveyDate,
  });
}

class _NetPriceScreenState extends State<NetPriceScreen> {
  final List<NetPriceSurveyItem> _surveys = [
    NetPriceSurveyItem(
      brandName: 'VFM (Vietnam Flour Mills)',
      productName: "Baker's Choice Số 11",
      packaging: 'Bao 25kg',
      wholesalePriceNet: 410000,
      retailPriceToBakery: 425000,
      discountPercent: 3.5,
      competitorPromo: 'Chiết khấu đạt mốc tháng + hỗ trợ công nợ 30 ngày',
      surveyDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
    NetPriceSurveyItem(
      brandName: 'Đối thủ (Bột mì Bình Đông)',
      productName: 'Bột mì Bình Đông Xanh 25kg',
      packaging: 'Bao 25kg',
      wholesalePriceNet: 395000,
      retailPriceToBakery: 410000,
      discountPercent: 4.0,
      competitorPromo: 'Tặng 1 bao khi mua 20 bao trong tuần đầu tháng',
      surveyDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  void _openCreateSurveyDialog() {
    String brand = "VFM";
    final prodCtrl = TextEditingController(text: "Baker's Choice Số 13");
    final wholesaleCtrl = TextEditingController(text: '435000');
    final retailCtrl = TextEditingController(text: '450000');
    final discountCtrl = TextEditingController(text: '3.0');
    final promoCtrl = TextEditingController();

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
                        'Thu thập thông tin giá NET thị trường',
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

                  const Text('Thương hiệu / Nhà sản xuất *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: brand,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'VFM', child: Text('VFM (Vietnam Flour Mills)')),
                          DropdownMenuItem(value: 'Bình Đông', child: Text('Bột mì Bình Đông')),
                          DropdownMenuItem(value: 'Đại Phong', child: Text('Bột mì Đại Phong')),
                          DropdownMenuItem(value: 'CJ-SC', child: Text('Bột mì CJ-SC Global')),
                          DropdownMenuItem(value: 'Khác', child: Text('Thương hiệu khác')),
                        ],
                        onChanged: (v) => setMState(() => brand = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Tên sản phẩm bột mì *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: prodCtrl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Giá NET đại lý (đ/bao)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: wholesaleCtrl,
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Giá bán ra lò (đ/bao)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: retailCtrl,
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

                  const Text('Chiết khấu (%) & Khuyến mãi đối thủ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: promoCtrl,
                    decoration: InputDecoration(
                      hintText: 'VD: Chiết khấu 3.5%, tặng khay nướng, thưởng quý...',
                      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF989799)),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      final wsPrice = double.tryParse(wholesaleCtrl.text) ?? 400000;
                      final rtPrice = double.tryParse(retailCtrl.text) ?? 420000;
                      final disc = double.tryParse(discountCtrl.text) ?? 3.0;

                      final record = NetPriceSurveyItem(
                        brandName: brand,
                        productName: prodCtrl.text.trim(),
                        packaging: 'Bao 25kg',
                        wholesalePriceNet: wsPrice,
                        retailPriceToBakery: rtPrice,
                        discountPercent: disc,
                        competitorPromo: promoCtrl.text.trim().isNotEmpty
                            ? promoCtrl.text.trim()
                            : 'Không có ghi nhận chương trình đặc biệt',
                        surveyDate: DateTime.now(),
                      );
                      setState(() {
                        _surveys.insert(0, record);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã lưu dữ liệu giá NET thành công!'),
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
                      'Lưu thông tin giá NET',
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
          'Thu thập thông tin giá NET',
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
                  const Icon(Icons.price_check, color: VfmColors.primaryGreen, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.store.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_surveys.length} mẫu giá',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _surveys.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, index) {
                  final item = _surveys[index];
                  return _buildPriceCard(item);
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
                  onPressed: _openCreateSurveyDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Khảo sát giá NET mới',
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

  Widget _buildPriceCard(NetPriceSurveyItem item) {
    final isVfm = item.brandName.contains('VFM');
    final wsFmt = item.wholesalePriceNet
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    final rtFmt = item.retailPriceToBakery
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isVfm ? VfmColors.primaryGreen.withOpacity(0.5) : const Color(0xFFD1D8DB),
          width: isVfm ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.productName,
                  style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111418)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isVfm ? const Color(0xFFD8FFEE) : const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isVfm ? 'Sản phẩm VFM' : 'Đối thủ',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isVfm ? VfmColors.primaryGreen : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.brandName,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const Divider(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Giá NET đại lý', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    Text('$wsFmt đ', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111418))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Giá bán ra lò', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    Text('$rtFmt đ', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VfmColors.primaryGreen)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chiết khấu', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    Text('${item.discountPercent}%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2563EB))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FBF3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 14, color: VfmColors.primaryGreen),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.competitorPromo,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF333333), fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
