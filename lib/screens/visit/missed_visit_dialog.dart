import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class MissedVisitDialog extends StatefulWidget {
  final StoreItem store;
  final Function(String reason, String note) onSubmit;

  const MissedVisitDialog({
    super.key,
    required this.store,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required StoreItem store,
    required Function(String reason, String note) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MissedVisitDialog(store: store, onSubmit: onSubmit),
    );
  }

  @override
  State<MissedVisitDialog> createState() => _MissedVisitDialogState();
}

class _MissedVisitDialogState extends State<MissedVisitDialog> {
  String? _selectedReason;
  final TextEditingController _noteController = TextEditingController();
  final int _maxChars = 200;

  final List<String> _reasons = const [
    'Đóng cửa',
    'Chủ cửa hàng vắng mặt',
    'Khách hàng bận tiếp khách khác',
    'Sự cố giao thông / Thời tiết',
    'Khách hẹn dời lịch viếng thăm',
    'Khác',
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = _selectedReason != null;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chọn lý do lỡ thăm viếng',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111418),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 22, color: Color(0xFF6B7280)),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Store quick header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6FBF3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.storefront, color: VfmColors.primaryGreen, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.store.name,
                            style: const TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111418),
                            ),
                          ),
                          Text(
                            'Mã: ${widget.store.branchCode} • ${widget.store.channel}',
                            style: const TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Reason Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text(
                      'Lý do',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111418),
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Reason Radio List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: _reasons.map((reason) {
                    final isSelected = _selectedReason == reason;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedReason = reason;
                        });
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEAF5EF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: reason,
                              groupValue: _selectedReason,
                              activeColor: VfmColors.primaryGreen,
                              onChanged: (val) {
                                setState(() {
                                  _selectedReason = val;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                reason,
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  color: const Color(0xFF111418),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 14),

              // Note Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ghi chú',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111418),
                          ),
                        ),
                        Text(
                          '${_noteController.text.length}/$_maxChars',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _noteController,
                      maxLines: 3,
                      maxLength: _maxChars,
                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                      onChanged: (val) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Nhập ghi chú chi tiết...',
                        hintStyle: const TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 14,
                          color: Color(0xFF989799),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFFD1D8DB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFFD1D8DB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: VfmColors.primaryGreen, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: canSubmit
                        ? () {
                            Navigator.pop(context);
                            widget.onSubmit(_selectedReason!, _noteController.text.trim());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VfmColors.primaryGreen,
                      disabledBackgroundColor: const Color(0xFFE5E7EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Gửi',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: canSubmit ? Colors.white : const Color(0xFF989799),
                      ),
                    ),
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
}
