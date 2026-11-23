import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleScreenState();
}

class ScheduleTicketItem {
  final String title;
  final String type; // 'Đi thị trường' | 'Văn phòng' | 'Ngày nghỉ'
  final String dateRange;
  final String description;
  final List<String> stores;

  ScheduleTicketItem({
    required this.title,
    required this.type,
    required this.dateRange,
    required this.description,
    required this.stores,
  });
}

class _WorkScheduleScreenState extends State<WorkScheduleScreen> {
  int _selectedDayIndex = 2; // Default to Wednesday / today

  final List<String> _daysOfWeek = ['T2\n17', 'T3\n18', 'T4\n19', 'T5\n20', 'T6\n21', 'T7\n22', 'CN\n23'];

  final List<ScheduleTicketItem> _tickets = [
    ScheduleTicketItem(
      title: 'Đi thị trường Vùng Miền Nam 1 - Kênh Bakery',
      type: 'Đi thị trường',
      dateRange: '19/08/2026 (08:00 - 17:30)',
      description: 'Chăm sóc tiệm bánh chủ lực, thử mẫu bột Baker’s Choice Số 11 và giải quyết sự cố nướng bánh',
      stores: [
        'Cửa hàng bánh phường Nhiêu Lộc',
        'Cửa hàng bánh phường An Khánh',
        'Cửa hàng bánh phường Xuân Hòa',
        'Tiệm bánh Hỷ Lâm Môn Quận 5',
      ],
    ),
    ScheduleTicketItem(
      title: 'Họp giao ban định kỳ & Tổng kết số liệu tuần',
      type: 'Văn phòng',
      dateRange: '21/08/2026 (14:00 - 16:30)',
      description: 'Báo cáo sản lượng tiêu thụ bột mì tháng 8 và đề xuất hạn mức tín dụng cho đại lý mới',
      stores: [
        'Văn phòng VFM Tòa nhà IPC',
      ],
    ),
  ];

  void _openCreateScheduleDialog() {
    final titleCtrl = TextEditingController(text: 'Đi thị trường tuyến Quận 1 & Bình Thạnh');
    String type = 'Đi thị trường';
    final descCtrl = TextEditingController(text: 'Thăm viếng và giới thiệu bột mì mới');

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
                        'Đăng ký lịch làm việc / Tuyến đi',
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

                  const Text('Hình thức làm việc *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD1D8DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: type,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'Đi thị trường', child: Text('Đi thị trường (Viếng thăm khách hàng)')),
                          DropdownMenuItem(value: 'Văn phòng', child: Text('Làm việc văn phòng (Họp / Báo cáo)')),
                          DropdownMenuItem(value: 'Đi lân la', child: Text('Đi lân la (Tìm kiếm khách hàng mới)')),
                          DropdownMenuItem(value: 'Ngày nghỉ', child: Text('Đăng ký ngày nghỉ phép')),
                        ],
                        onChanged: (v) => setMState(() => type = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Tiêu đề lịch trình *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleCtrl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Mô tả mục tiêu chuyến đi', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      final newTicket = ScheduleTicketItem(
                        title: titleCtrl.text.trim(),
                        type: type,
                        dateRange: '23/08/2026 (08:30 - 17:00)',
                        description: descCtrl.text.trim(),
                        stores: ['Cửa hàng bánh phường An Khánh', 'Tiệm bánh Tous les Jours Lê Thánh Tôn'],
                      );
                      setState(() {
                        _tickets.insert(0, newTicket);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã đăng ký lịch làm việc mới thành công!'),
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
                      'Lưu lịch làm việc',
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
          'Lịch làm việc',
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
            icon: const Icon(Icons.calendar_month, color: VfmColors.primaryGreen),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mở xem lịch tháng')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Week Calendar Strip
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_daysOfWeek.length, (idx) {
                  final isSelected = _selectedDayIndex == idx;
                  return InkWell(
                    onTap: () => setState(() => _selectedDayIndex = idx),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 44,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? VfmColors.primaryGreen : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? VfmColors.primaryGreen : const Color(0xFFD1D8DB),
                        ),
                      ),
                      child: Text(
                        _daysOfWeek[idx],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 12,
                          height: 1.3,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF111418),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider(height: 1),

            // Tickets List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _tickets.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (ctx, index) {
                  final ticket = _tickets[index];
                  return _buildWorkScheduleTicket(ticket);
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
                child: ElevatedButton.icon(
                  onPressed: _openCreateScheduleDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Đăng ký lịch làm việc mới',
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

  Widget _buildWorkScheduleTicket(ScheduleTicketItem ticket) {
    final isField = ticket.type == 'Đi thị trường';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD1D8DB)),
        boxShadow: const [
          BoxShadow(color: Color(0x06000000), offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isField ? const Color(0xFFEAF5EF) : const Color(0xFFF3F4F6),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isField ? Icons.directions_car : Icons.business,
                      size: 18,
                      color: isField ? VfmColors.primaryGreen : const Color(0xFF4B5563),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.type,
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isField ? VfmColors.primaryGreen : const Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                Text(
                  ticket.dateRange,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111418),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ticket.description,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                ),
                const Divider(height: 18),
                const Text(
                  'Danh sách khách hàng lên lịch:',
                  style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111418)),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: ticket.stores.map((store) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6FBF3),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFD1D8DB)),
                      ),
                      child: Text(
                        store,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF2D6A44), fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
