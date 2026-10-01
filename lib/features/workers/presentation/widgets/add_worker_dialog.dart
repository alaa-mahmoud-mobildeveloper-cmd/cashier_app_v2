import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';
import '../../domain/entities/worker_creation_request.dart';

class AddWorkerDialog extends StatefulWidget {
  const AddWorkerDialog({super.key});

  @override
  State<AddWorkerDialog> createState() => _AddWorkerDialogState();
}

class _AddWorkerDialogState extends State<AddWorkerDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final customRoleController = TextEditingController();
  final salaryController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String _selectedJobType = 'عامل';
  bool _obscurePassword = true;

  bool get _isCashier => _selectedJobType == 'كاشير';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    customRoleController.dispose();
    salaryController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return 'أدخل $fieldName';
    return null;
  }

  String? _validateUsername(String? value) {
    final username = value?.trim() ?? '';
    if (username.length < 3 || username.length > 50) {
      return 'اسم المستخدم يجب أن يكون بين 3 و50 حرفًا';
    }
    if (RegExp(r'\s').hasMatch(username)) {
      return 'لا تستخدم مسافات في اسم المستخدم';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.length < 12) {
      return 'كلمة المرور يجب أن تكون 12 حرفًا على الأقل';
    }
    if (password.length > 256) return 'كلمة المرور طويلة جدًا';
    return null;
  }

  void saveWorker() {
    if (!formKey.currentState!.validate()) return;

    final salary = double.tryParse(salaryController.text.trim());
    if (salary == null || salary < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('أدخل راتبًا صحيحًا')));
      return;
    }

    final jobTitle = _selectedJobType == 'أخرى'
        ? customRoleController.text.trim()
        : _selectedJobType;
    final worker = Worker(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      role: jobTitle,
      salary: salary,
      status: WorkerStatus.active,
    );

    Navigator.of(context).pop(
      WorkerCreationRequest(
        worker: worker,
        username: _isCashier ? usernameController.text.trim() : null,
        password: _isCashier ? passwordController.text : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة عامل جديد'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) => _validateRequired(value, 'اسم العامل'),
                  decoration: const InputDecoration(
                    labelText: 'اسم العامل',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) => _validateRequired(value, 'رقم الهاتف'),
                  decoration: const InputDecoration(
                    labelText: 'رقم الهاتف',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedJobType,
                  decoration: const InputDecoration(
                    labelText: 'الوظيفة',
                    prefixIcon: Icon(Icons.work_outline),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'عامل', child: Text('عامل')),
                    DropdownMenuItem(value: 'كاشير', child: Text('كاشير')),
                    DropdownMenuItem(value: 'أخرى', child: Text('أخرى')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _selectedJobType = value);
                  },
                ),
                if (_selectedJobType == 'أخرى') ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: customRoleController,
                    validator: (value) => _selectedJobType == 'أخرى'
                        ? _validateRequired(value, 'الوظيفة')
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'اسم الوظيفة',
                      prefixIcon: Icon(Icons.edit_outlined),
                    ),
                  ),
                ],
                if (_isCashier) ...[
                  const SizedBox(height: 16),
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'بيانات دخول الكاشير',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: usernameController,
                    autocorrect: false,
                    validator: _isCashier ? _validateUsername : null,
                    decoration: const InputDecoration(
                      labelText: 'اسم المستخدم',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    validator: _isCashier ? _validatePassword : null,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور (12 حرفًا على الأقل)',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (!_isCashier) return null;
                      if (value != passwordController.text) {
                        return 'كلمتا المرور غير متطابقتين';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'تأكيد كلمة المرور',
                      prefixIcon: Icon(Icons.lock_reset_outlined),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: salaryController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) => _validateRequired(value, 'الراتب'),
                  decoration: const InputDecoration(
                    labelText: 'الراتب',
                    suffixText: 'ج',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'إلغاء',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(onPressed: saveWorker, child: const Text('حفظ العامل')),
      ],
    );
  }
}
