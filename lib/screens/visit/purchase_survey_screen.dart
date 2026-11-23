import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class PurchaseSurveyScreen extends StatefulWidget {
  final StoreItem store;

  const PurchaseSurveyScreen({super.key, required this.store});

  @override
  State<PurchaseSurveyScreen> createState() => _PurchaseSurveyScreenState();
}

class PurchaseItemRecord {
  final String productName;
  final String packageType;
  final int quantity;
  final double unitPrice;
  final DateTime orderDate;
  final String note;

  PurchaseItemRecord({
    required this.productName,
    required this.packageType,
    required this.quantity,
    required this.unitPrice,
    required this.orderDate,
    required this.note,
  });

  double get totalAmount => quantity * unitPrice;
}

class _PurchaseSurveyScreenState extends State<PurchaseSurveyScreen> {
  final List<PurchaseItemRecord> _records = [
    PurchaseItemRecord(
      productName: "Baker's Choice Số 11 (Bột làm bánh mì)",
      packageType: 'Bao 25kg',
      quantity: 40,
      unitPrice: 425000,
      orderDate: DateTime.now().subtract(const Duration(days: 3)),
      note: 'Giao sáng thứ 3 trước 9h',
    ),
    PurchaseItemRecord(
      productName: 'Bột mì Hoa Ngọc Lan cao cấp',
      packageType: 'Bao 25kg',
      quantity: 20,
      unitPrice: 390000,
      orderDate: DateTime.now().subtract(const Duration(days: 10)),
      note: 'Dùng thử cho mẻ bánh ngọt',
    ),
  ];

  void _openCreateRecordDialog() {
    String selectedProduct = "Baker's Choice Số 11 (Bột làm bánh mì)";
    String packageType = 'Bao 25kg';
    final qtyCtrl = TextEditingController(text: '10');
    final priceCtrl = TextEditingController(text: '425000');
    final noteCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          final int qty = int.tryParse(qtyCtrl.text) ?? 0;
          final double price = double.tryParse(priceCtrl.text) ?? 0;
          final double total = qty * price;

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
                        'Tạo phiếu mua hàng / Khảo sát',
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

                  // Product Dropdown
                  const Text('Sản phẩm bột mì VFM *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedProduct,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: "Baker's Choice Số 11 (Bột làm bánh mì)",
                            child: Text("Baker's Choice Số 11 (Bánh mì)"),
                          ),
                          DropdownMenuItem(
                            value: "Baker's Choice Số 13 (Bột bánh mì dai)",
                            child: Text("Baker's Choice Số 13 (Dai/Sandwich)"),
                          ),
                          DropdownMenuItem(
                            value: "Baker's Choice Số 8 (Bột bánh bông lan)",
                            child: Text("Baker's Choice Số 8 (Bông lan)"),
                          ),
                          DropdownMenuItem(
                            value: 'Bột mì Hoa Ngọc Lan cao cấp',
                            child: Text('Bột mì Hoa Ngọc Lan'),
                          ),
                          DropdownMenuItem(
                            value: 'Bột mì Meizan đa dụng',
                            child: Text('Bột mì Meizan đa dụng'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() {
                              selectedProduct = val;
                              if (val.contains('Số 13')) {
                                priceCtrl.text = '450000';
                              } else if (val.contains('Số 8')) {
                                priceCtrl.text = '380000';
                              } else {
                                priceCtrl.text = '425000';
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Package & Quantity
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Quy cách đóng gói', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFD1D8DB)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: packageType,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'Bao 25kg', child: Text('Bao 25kg')),
                                    DropdownMenuItem(value: 'Bao 40kg', child: Text('Bao 40kg')),
                                    DropdownMenuItem(value: 'Gói 1kg (Thùng 10)', child: Text('Gói 1kg')),
                                  ],
                                  onChanged: (v) => setModalState(() => packageType = v!),
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
                            const Text('Số lượng *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: qtyCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setModalState(() {}),
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

                  // Unit price
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Đơn giá dự kiến (VNĐ)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: priceCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setModalState(() {}),
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

                  // Total preview
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FBF3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thành tiền dự kiến:',
                          style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} đ',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: VfmColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Note field
                  const Text('Ghi chú đơn hàng / Lò nướng', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: noteCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Nhập ghi chú giao nhận hoặc yêu cầu lò bánh...',
                      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF989799)),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      if (qty <= 0) return;
                      final record = PurchaseItemRecord(
                        productName: selectedProduct,
                        packageType: packageType,
                        quantity: qty,
                        unitPrice: price,
                        orderDate: DateTime.now(),
                        note: noteCtrl.text.trim(),
                      );
                      setState(() {
                        _records.insert(0, record);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã thêm phiếu thu thập thông tin mua hàng thành công!'),
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
                      'Lưu phiếu mua hàng',
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
          'Thu thập thông tin mua hàng',
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
            // Store Quick Info Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.storefront, color: VfmColors.primaryGreen, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.store.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_records.length} phiếu',
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Records List
            Expanded(
              child: _records.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.receipt_long_outlined, size: 56, color: Color(0xFF989799)),
                          SizedBox(height: 12),
                          Text('Chưa có thông tin mua hàng nào', style: TextStyle(color: Color(0xFF6B7280))),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _records.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, index) {
                        final item = _records[index];
                        return _buildRecordCard(item);
                      },
                    ),
            ),

            // Bottom Add Button
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _openCreateRecordDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Tạo phiếu mua hàng mới',
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

  Widget _buildRecordCard(PurchaseItemRecord item) {
    final formattedPrice = item.totalAmount
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D8DB)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), offset: Offset(0, 2), blurRadius: 4),
        ],
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
                  style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111418)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD8FFEE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Đã ghi nhận',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: VfmColors.primaryGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Quy cách: ${item.packageType}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const SizedBox(width: 12),
              Text(
                'Số lượng: ${item.quantity} bao',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111418)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền: $formattedPrice đ',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VfmColors.primaryGreen),
              ),
              Text(
                '${item.orderDate.day}/${item.orderDate.month}/${item.orderDate.year}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF989799)),
              ),
            ],
          ),
          if (item.note.isNotEmpty) ...[
            const Divider(height: 14),
            Row(
              children: [
                const Icon(Icons.notes, size: 14, color: Color(0xFF6B7280)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.note,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
