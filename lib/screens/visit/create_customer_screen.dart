import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/vfm_colors.dart';

class CreateCustomerScreen extends StatefulWidget {
  final bool isBranchOnly;
  final StoreItem? parentStore;

  const CreateCustomerScreen({
    super.key,
    this.isBranchOnly = false,
    this.parentStore,
  });

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  int _currentStep = 0;

  // Controllers for Step 1 (Customer Info)
  final _customerNameCtrl = TextEditingController();
  final _taxCodeCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String _customerStatus = 'Đang mua hàng';
  String _customerCountry = 'Việt Nam';

  // Controllers for Step 2 (Branch Info)
  final _branchNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _latCtrl = TextEditingController(text: '10.7769');
  final _lngCtrl = TextEditingController(text: '106.7009');
  final _decisionMakerCtrl = TextEditingController();
  final _zaloPhoneCtrl = TextEditingController();
  bool _isDefaultBranch = true;
  String _channel = 'Modern Trade';
  String _customerType = 'Người dùng cuối';
  String _paymentMethod = 'Trực tiếp';
  String _province = 'TP. Hồ Chí Minh';
  String _district = 'Quận 1';

  @override
  void initState() {
    super.initState();
    if (widget.isBranchOnly && widget.parentStore != null) {
      _customerNameCtrl.text = widget.parentStore!.name;
      _currentStep = 1; // start on branch step
    }
  }

  @override
  void dispose() {
    _customerNameCtrl.dispose();
    _taxCodeCtrl.dispose();
    _contactPersonCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _branchNameCtrl.dispose();
    _addressCtrl.dispose();
    _latCtrl.dispose();
    _lngCtrl.dispose();
    _decisionMakerCtrl.dispose();
    _zaloPhoneCtrl.dispose();
    super.dispose();
  }

  void _getGpsLocation() {
    setState(() {
      _latCtrl.text = '10.7932';
      _lngCtrl.text = '106.6914';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã cập nhật toạ độ GPS chính xác theo vị trí hiện tại!'),
        backgroundColor: VfmColors.primaryGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onNext() {
    if (_currentStep == 0) {
      if (_customerNameCtrl.text.trim().isEmpty) {
        _showError('Vui lòng nhập tên khách hàng');
        return;
      }
      if (_contactPersonCtrl.text.trim().isEmpty) {
        _showError('Vui lòng nhập người liên hệ');
        return;
      }
      if (_phoneCtrl.text.trim().isEmpty) {
        _showError('Vui lòng nhập số điện thoại');
        return;
      }
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      if (_branchNameCtrl.text.trim().isEmpty) {
        _showError('Vui lòng nhập tên chi nhánh');
        return;
      }
      if (_addressCtrl.text.trim().isEmpty) {
        _showError('Vui lòng nhập địa chỉ chi nhánh');
        return;
      }
      setState(() => _currentStep = 2);
    } else {
      _finishCreate();
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: VfmColors.error),
    );
  }

  void _finishCreate() {
    final newStore = StoreItem(
      id: 'C${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      name: _branchNameCtrl.text.trim().isNotEmpty
          ? _branchNameCtrl.text.trim()
          : _customerNameCtrl.text.trim(),
      branchCode: 'C${DateTime.now().millisecond}',
      status: VisitStatus.pending,
      channel: _channel,
      customerType: _customerType,
      paymentMethod: _paymentMethod,
      distance: '15.00m',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: VfmColors.primaryGreen, size: 28),
            SizedBox(width: 8),
            Text(
              'Thành công',
              style: TextStyle(fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          widget.isBranchOnly
              ? 'Chi nhánh mới "${newStore.name}" đã được thêm thành công!'
              : 'Khách hàng "${_customerNameCtrl.text}" và chi nhánh "${newStore.name}" đã được tạo thành công!',
          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, newStore);
            },
            child: const Text(
              'Hoàn tất',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.bold,
                color: VfmColors.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isBranchOnly ? 'Thêm chi nhánh mới' : 'Tạo khách hàng mới';

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF3),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
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
          onPressed: () {
            if (_currentStep > 0 && !widget.isBranchOnly) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Stepper Tabs
            _buildStepperHeader(),

            // Content per step
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildStepContent(),
              ),
            ),

            // Bottom CTA
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildStepTab(0, '1. TT khách hàng', !widget.isBranchOnly),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF989799)),
          const SizedBox(width: 8),
          _buildStepTab(1, '2. TT chi nhánh', true),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF989799)),
          const SizedBox(width: 8),
          _buildStepTab(2, '3. Xác nhận', true),
        ],
      ),
    );
  }

  Widget _buildStepTab(int stepIndex, String title, bool enabled) {
    final isActive = _currentStep == stepIndex;
    final isDone = _currentStep > stepIndex;

    Color bg = const Color(0xFFE5E7EB);
    Color textCol = const Color(0xFF6B7280);

    if (isActive) {
      bg = const Color(0xFFD8FFEE);
      textCol = VfmColors.primaryGreen;
    } else if (isDone) {
      bg = const Color(0xFFEAEFE8);
      textCol = const Color(0xFF2D6A44);
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: isActive
              ? Border.all(color: VfmColors.primaryGreen, width: 1.2)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: textCol,
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Customer();
      case 1:
        return _buildStep2Branch();
      case 2:
      default:
        return _buildStep3Review();
    }
  }

  Widget _buildStep1Customer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Thông tin cơ bản khách hàng'),
        _buildTextField('Tên khách hàng', _customerNameCtrl, hint: 'Nhập tên tiệm bánh / công ty', isRequired: true),
        _buildTextField('Mã số thuế', _taxCodeCtrl, hint: 'Nhập mã số thuế (nếu có)'),
        _buildTextField('Người liên hệ chính', _contactPersonCtrl, hint: 'Họ và tên người đại diện', isRequired: true),
        _buildTextField('Số điện thoại liên hệ', _phoneCtrl, hint: '09xx xxx xxx', isRequired: true, keyboardType: TextInputType.phone),
        _buildTextField('Email', _emailCtrl, hint: 'example@bakery.com', keyboardType: TextInputType.emailAddress),
        _buildDropdown(
          label: 'Trạng thái mua hàng',
          value: _customerStatus,
          items: const ['Đang mua hàng', 'Tiềm năng', 'Tạm dừng'],
          onChanged: (val) => setState(() => _customerStatus = val!),
        ),
        _buildDropdown(
          label: 'Quốc gia bán hàng',
          value: _customerCountry,
          items: const ['Việt Nam', 'Campuchia', 'Lào'],
          onChanged: (val) => setState(() => _customerCountry = val!),
        ),
        const SizedBox(height: 12),
        // Giấy phép kinh doanh container
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D8DB)),
          ),
          child: Row(
            children: [
              const Icon(Icons.attach_file, color: VfmColors.primaryGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Giấy phép kinh doanh / ĐKKD',
                      style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Tải ảnh chụp giấy tờ xác minh (tuỳ chọn)',
                      style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã đính kèm ảnh giấy phép thành công')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: VfmColors.primaryGreen),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: const Size(60, 32),
                ),
                child: const Text('Tải lên', style: TextStyle(color: VfmColors.primaryGreen, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2Branch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Thông tin chi nhánh & Điểm bán'),
        _buildTextField('Tên chi nhánh', _branchNameCtrl, hint: 'VD: Chi nhánh Quận 1 / Cửa hàng Thị Nghè', isRequired: true),
        // Checkbox Chi nhánh mặc định
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD1D8DB)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _isDefaultBranch,
                activeColor: VfmColors.primaryGreen,
                onChanged: (val) => setState(() => _isDefaultBranch = val ?? true),
              ),
              const Text(
                'Đặt làm chi nhánh chính / mặc định',
                style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        _buildDropdown(
          label: 'Kênh khách hàng',
          value: _channel,
          items: const ['Modern Trade', 'General Trade', 'Bakery Shop', 'Horeca'],
          onChanged: (val) => setState(() => _channel = val!),
        ),
        _buildDropdown(
          label: 'Loại khách hàng',
          value: _customerType,
          items: const ['Người dùng cuối', 'Đại lý cấp 1', 'Đại lý cấp 2', 'Chuỗi bán lẻ'],
          onChanged: (val) => setState(() => _customerType = val!),
        ),
        _buildDropdown(
          label: 'Phương thức mua bán',
          value: _paymentMethod,
          items: const ['Trực tiếp', 'Gián tiếp qua NPP', 'Công nợ 30 ngày'],
          onChanged: (val) => setState(() => _paymentMethod = val!),
        ),
        _buildDropdown(
          label: 'Tỉnh / Thành phố',
          value: _province,
          items: const ['TP. Hồ Chí Minh', 'Hà Nội', 'Đà Nẵng', 'Bình Dương', 'Đồng Nai'],
          onChanged: (val) => setState(() => _province = val!),
        ),
        _buildDropdown(
          label: 'Quận / Huyện',
          value: _district,
          items: const ['Quận 1', 'Quận 3', 'Bình Thạnh', 'Tân Bình', 'Thủ Đức'],
          onChanged: (val) => setState(() => _district = val!),
        ),
        _buildTextField('Địa chỉ chi tiết', _addressCtrl, hint: 'Số nhà, tên đường, phường...', isRequired: true),
        
        // GPS Coordinates
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
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
                  const Text(
                    'Định vị GPS cửa hàng',
                    style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  TextButton.icon(
                    onPressed: _getGpsLocation,
                    icon: const Icon(Icons.my_location, size: 16, color: VfmColors.primaryGreen),
                    label: const Text('Lấy toạ độ GPS', style: TextStyle(color: VfmColors.primaryGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _buildCoordField('Vĩ độ (Lat)', _latCtrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCoordField('Kinh độ (Lng)', _lngCtrl),
                  ),
                ],
              ),
            ],
          ),
        ),

        _buildTextField('Người ra quyết định mua hàng', _decisionMakerCtrl, hint: 'Họ tên chủ tiệm / Quản lý'),
        _buildTextField('Số điện thoại Zalo', _zaloPhoneCtrl, hint: 'Số Zalo nhận tin CTKM', keyboardType: TextInputType.phone),
      ],
    );
  }

  Widget _buildStep3Review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Xác nhận thông tin đã nhập'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD1D8DB)),
            boxShadow: const [
              BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              _buildReviewRow('Khách hàng', _customerNameCtrl.text.isEmpty ? 'Chưa nhập' : _customerNameCtrl.text),
              const Divider(height: 20),
              _buildReviewRow('Người liên hệ', _contactPersonCtrl.text.isEmpty ? 'Chưa nhập' : _contactPersonCtrl.text),
              const Divider(height: 20),
              _buildReviewRow('Số điện thoại', _phoneCtrl.text.isEmpty ? 'Chưa nhập' : _phoneCtrl.text),
              const Divider(height: 20),
              _buildReviewRow('Chi nhánh', _branchNameCtrl.text.isEmpty ? 'Chi nhánh chính' : _branchNameCtrl.text),
              const Divider(height: 20),
              _buildReviewRow('Kênh / Loại KH', '$_channel • $_customerType'),
              const Divider(height: 20),
              _buildReviewRow('Địa chỉ', '${_addressCtrl.text}, $_district, $_province'),
              const Divider(height: 20),
              _buildReviewRow('Toạ độ GPS', '${_latCtrl.text}, ${_lngCtrl.text}'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFB800)),
          ),
          child: Row(
            children: const [
              Icon(Icons.info_outline, color: Color(0xFFB45309), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Thông tin sẽ được gửi lên hệ thống DMS để phê duyệt và tự động thêm vào lịch trình thăm viếng.',
                  style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFFB45309)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF111418),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111418),
                ),
              ),
              if (isRequired)
                const Text(' *', style: TextStyle(color: VfmColors.error, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF989799), fontSize: 13),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
    );
  }

  Widget _buildCoordField(String label, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 12, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: const Color(0xFFF6FBF3),
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD1D8DB)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111418),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFD1D8DB)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.contains(value) ? value : items.first,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
                items: items.map((it) {
                  return DropdownMenuItem<String>(
                    value: it,
                    child: Text(it, style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 14)),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final isLastStep = _currentStep == 2;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x0F000000), offset: Offset(0, -2), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D8DB)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Quay lại', style: TextStyle(color: Color(0xFF111418), fontWeight: FontWeight.w600)),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: VfmColors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: Text(
                isLastStep ? 'Xác nhận & Lưu' : 'Tiếp theo',
                style: const TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
