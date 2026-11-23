import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';
import '../auth/login_screen.dart';
import '../schedule/work_schedule_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _openChangePasswordDialog() {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    bool obscure = true;

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
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20,
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
                        'Đổi mật khẩu tài khoản',
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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

                  const Text('Mật khẩu hiện tại *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: oldPassCtrl,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      hintText: 'Nhập mật khẩu đang dùng',
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Mật khẩu mới *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: newPassCtrl,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      hintText: 'Tối thiểu 8 ký tự, gồm chữ và số',
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text('Xác nhận mật khẩu mới *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: confirmPassCtrl,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      hintText: 'Nhập lại mật khẩu mới',
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () {
                      if (newPassCtrl.text != confirmPassCtrl.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mật khẩu xác nhận không trùng khớp!'), backgroundColor: VfmColors.error),
                        );
                        return;
                      }
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đổi mật khẩu thành công!'),
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
                      'Cập nhật mật khẩu',
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

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Đăng xuất tài khoản', style: TextStyle(fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng VFM Bakery? Mọi dữ liệu đã lưu trên đám mây an toàn.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
            ),
            child: const Text('Đăng xuất', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3), // Neutral surface from Figma 1035:61193
      appBar: AppBar(
        title: const Text(
          'Mở rộng & Hồ sơ cá nhân',
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Card from Figma node 167:22647
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8FFEE),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: VfmColors.primaryGreen, width: 1.5),
                      ),
                      child: const Center(
                        child: Text(
                          'TÚ',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: VfmColors.primaryGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nguyễn Văn Tú',
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111418),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Nhân viên bán hàng (Sales Rep)',
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Mã NV: VFM-2026 • Tuyến Q1 - Bình Thạnh',
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 11,
                              color: Color(0xFF989799),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Menu Group Container (Figma 1035:61196)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      title: 'Hồ sơ của tôi',
                      icon: Icons.badge_outlined,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Hồ sơ nhân viên: Nguyễn Văn Tú - VFM Sales')),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 48),
                    _buildMenuItem(
                      title: 'Lịch làm việc của tôi',
                      icon: Icons.calendar_today_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WorkScheduleScreen()),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 48),
                    _buildMenuItem(
                      title: 'Đổi mật khẩu',
                      icon: Icons.lock_outline,
                      onTap: _openChangePasswordDialog,
                    ),
                    const Divider(height: 1, indent: 48),
                    _buildMenuItem(
                      title: 'Cài đặt định vị GPS & Bản đồ',
                      icon: Icons.my_location,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('GPS: Độ chính xác cao, bán kính check-in 50m')),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 48),
                    _buildMenuItem(
                      title: 'Đồng bộ dữ liệu ngoại tuyến (Offline)',
                      icon: Icons.sync,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã đồng bộ 100% dữ liệu với máy chủ VFM')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Policy and info container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD1D8DB)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      title: 'Chính sách bảo mật & Hướng dẫn sử dụng',
                      icon: Icons.help_outline,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Xem tài liệu hướng dẫn quy trình bán hàng VFM')),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 48),
                    _buildMenuItem(
                      title: 'Phiên bản ứng dụng',
                      icon: Icons.info_outline,
                      trailing: const Text(
                        'v1.0.11 (Bakery SFA)',
                        style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFF6B7280)),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout Button from Figma 1035:61325
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _confirmLogout,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF4B5563), size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111418),
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF989799)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}
