import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class CustomerInfoDetailScreen extends StatelessWidget {
  final StoreItem store;

  const CustomerInfoDetailScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: const Text(
          'Thông tin khách hàng',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: VfmColors.primaryGreen),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chức năng chỉnh sửa thông tin')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Store Header Card
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
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8FFEE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.bakery_dining, color: VfmColors.primaryGreen, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store.name,
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111418),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Mã chi nhánh: ${store.branchCode}',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildMetaRow('Kênh phân phối', store.channel),
                    _buildMetaRow('Loại khách hàng', store.customerType),
                    _buildMetaRow('Hình thức thanh toán', store.paymentMethod),
                    _buildMetaRow('Khoảng cách GPS', store.distance),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Contact Info Section
              _buildSectionCard(
                title: 'Thông tin liên hệ & Đại diện',
                icon: Icons.person_outline,
                children: [
                  _buildMetaRow('Chủ sở hữu / Đại diện', 'Nguyễn Thị Hồng Mai'),
                  _buildMetaRow('Số điện thoại', '0908 123 456'),
                  _buildMetaRow('Số Zalo kinh doanh', '0908 123 456'),
                  _buildMetaRow('Email', 'hongmai.bakery@gmail.com'),
                  _buildMetaRow('Người đặt hàng', 'Anh Tuấn (Quản lý lò bánh)'),
                  _buildMetaRow('SĐT đặt hàng', '0912 888 999'),
                ],
              ),
              const SizedBox(height: 16),

              // Address & Location Section
              _buildSectionCard(
                title: 'Địa chỉ & Vị trí cửa hàng',
                icon: Icons.location_on_outlined,
                children: [
                  _buildMetaRow('Tỉnh / Thành phố', 'TP. Hồ Chí Minh'),
                  _buildMetaRow('Quận / Phường', 'Bình Thạnh, Phường 19'),
                  _buildMetaRow('Địa chỉ chi tiết', '128 Đường Xô Viết Nghệ Tĩnh, P.19, Q.Bình Thạnh'),
                  _buildMetaRow('Toạ độ GPS', '10.7932° N, 106.6914° E'),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEFE8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.map, color: VfmColors.primaryGreen, size: 32),
                          SizedBox(height: 4),
                          Text(
                            'Bản đồ vị trí cửa hàng',
                            style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, color: Color(0xFF2D6A44), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Commercial Terms
              _buildSectionCard(
                title: 'Chính sách & Công nợ',
                icon: Icons.receipt_long_outlined,
                children: [
                  _buildMetaRow('Hạn mức tín dụng', '150,000,000 đ'),
                  _buildMetaRow('Kỳ hạn thanh toán', '30 ngày'),
                  _buildMetaRow('Mức chiết khấu áp dụng', '3.5% / tháng'),
                  _buildMetaRow('Sản lượng trung bình', '12 tấn / tháng'),
                  _buildMetaRow('Dòng bột chủ lực', 'Baker’s Choice Số 11 & Số 13'),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
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
            children: [
              Icon(icon, color: VfmColors.primaryGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111418),
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111418),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
