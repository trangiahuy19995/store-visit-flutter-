import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum VisitStatus {
  visited(
    label: 'Đã thăm viếng',
    backgroundColor: AppColors.statusVisited,
    textColor: Colors.white,
  ),
  missed(
    label: 'Lỡ viếng thăm',
    backgroundColor: AppColors.statusMissed,
    textColor: Colors.white,
  ),
  pending(
    label: 'Chưa thăm viếng',
    backgroundColor: AppColors.statusPending,
    textColor: Colors.white,
  );

  final String label;
  final Color backgroundColor;
  final Color textColor;

  const VisitStatus({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}

class StoreItem {
  final String id;
  final String name;
  final String branchCode;
  final VisitStatus status;
  final String dateSchedule;
  final String channel;
  final String customerType;
  final String paymentMethod;
  final String distance;

  const StoreItem({
    required this.id,
    required this.name,
    required this.branchCode,
    required this.status,
    this.dateSchedule = 'Chủ Nhật, ngày 23 tháng 8 năm 2026 - 8:00 Sáng',
    this.channel = 'Modern Trade',
    this.customerType = 'Người dùng cuối',
    this.paymentMethod = 'Trực tiếp',
    this.distance = '50.00m',
  });
}

class VisitActivityItem {
  final String id;
  final String title;
  final IconData icon;

  const VisitActivityItem({
    required this.id,
    required this.title,
    required this.icon,
  });
}
