import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:flutter/material.dart';

class AdminDetailsScreen extends StatelessWidget {
  final User admin;

  const AdminDetailsScreen({super.key, required this.admin});

  String get _displayName =>
      admin.fullName.trim().isEmpty ? 'مدير النظام' : admin.fullName.trim();

  String get _initial => _displayName.characters.first.toUpperCase();

  String _formatDate(DateTime? value) {
    if (value == null) return 'لم يسجل بعد';
    final date = value.toLocal();
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year}  $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(compact ? 16 : 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(compact),
                    const SizedBox(height: 18),
                    _buildSection(
                      title: 'بيانات الحساب',
                      icon: Icons.admin_panel_settings_outlined,
                      children: [
                        _AdminInfoRow(
                          icon: Icons.badge_outlined,
                          label: 'رقم المستخدم',
                          value: '#${admin.id}',
                        ),
                        _AdminInfoRow(
                          icon: Icons.person_outline,
                          label: 'الاسم الكامل',
                          value: _displayName,
                        ),
                        _AdminInfoRow(
                          icon: Icons.alternate_email,
                          label: 'اسم المستخدم',
                          value: admin.username,
                        ),
                        const _AdminInfoRow(
                          icon: Icons.verified_user_outlined,
                          label: 'الدور',
                          value: 'مدير النظام',
                        ),
                        _AdminInfoRow(
                          icon: Icons.toggle_on_outlined,
                          label: 'حالة الحساب',
                          value: admin.isActive ? 'نشط' : 'موقوف',
                          valueColor: admin.isActive
                              ? AppColors.success
                              : AppColors.danger,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      title: 'بيانات التواصل',
                      icon: Icons.contact_page_outlined,
                      children: [
                        _AdminInfoRow(
                          icon: Icons.phone_outlined,
                          label: 'رقم الهاتف',
                          value: admin.phone?.trim().isNotEmpty == true
                              ? admin.phone!.trim()
                              : 'غير مسجل',
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      title: 'حالة الدخول وسجل الحساب',
                      icon: Icons.history_outlined,
                      children: [
                        _AdminInfoRow(
                          icon: Icons.login_outlined,
                          label: 'حالة الجلسة',
                          value: admin.isLoggedIn
                              ? 'مسجل الدخول الآن'
                              : 'غير مسجل الدخول',
                        ),
                        _AdminInfoRow(
                          icon: Icons.schedule_outlined,
                          label: 'آخر تسجيل دخول',
                          value: _formatDate(admin.lastLogin),
                        ),
                        _AdminInfoRow(
                          icon: Icons.event_available_outlined,
                          label: 'تاريخ إنشاء الحساب',
                          value: _formatDate(admin.createdAt),
                        ),
                        _AdminInfoRow(
                          icon: Icons.update_outlined,
                          label: 'آخر تحديث للبيانات',
                          value: _formatDate(admin.updatedAt),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.goldSurface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.goldDark),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lock_outline, color: AppColors.gold),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'بيانات كلمة المرور لا تظهر في هذه الشاشة حفاظًا على أمان الحساب.',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool compact) {
    return Container(
      padding: EdgeInsets.all(compact ? 18 : 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: compact ? 27 : 32,
            backgroundColor: AppColors.goldSurface,
            child: Text(
              _initial,
              style: const TextStyle(
                color: AppColors.goldLight,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'تفاصيل حساب الأدمن',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _displayName,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '@${admin.username}',
                  style: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: admin.isActive
                  ? AppColors.successSurface
                  : AppColors.dangerSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              admin.isActive ? 'نشط' : 'موقوف',
              style: TextStyle(
                color: admin.isActive ? AppColors.success : AppColors.danger,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.gold, size: 19),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.divider),
          for (var index = 0; index < children.length; index++) ...[
            if (index > 0) const SizedBox(height: 14),
            children[index],
          ],
        ],
      ),
    );
  }
}

class _AdminInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _AdminInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textHint, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.textHint, fontSize: 12),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
