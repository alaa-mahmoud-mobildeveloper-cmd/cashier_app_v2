import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final VoidCallback onAuthenticated;

  const LoginScreen({
    super.key,
    required this.authRepository,
    required this.onAuthenticated,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final user = await widget.authRepository.signIn(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('اسم المستخدم أو كلمة المرور غير صحيحة'),
          ),
        );
        return;
      }
      widget.onAuthenticated();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر تسجيل الدخول؛ تحقق من قاعدة البيانات'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48),
                        _buildLogo(),
                        const SizedBox(height: 32),
                        _buildHeader(),
                        const SizedBox(height: 32),
                        _buildForm(),
                        const Spacer(),
                        _buildFooter(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          color: AppColors.goldSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.goldDark, width: 1),
        ),
        child: const Icon(
          Icons.point_of_sale_rounded,
          color: AppColors.gold,
          size: 38,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 8),
        Text(
          'مرحباً بعودتك، سجّل الدخول لمتابعة العمل',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _fieldLabel('اسم المستخدم'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'أدخل اسم المستخدم',
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                color: AppColors.textHint,
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'من فضلك أدخل اسم المستخدم';
              }
              if (value.trim().length < 3 || value.trim().length > 50) {
                return 'اسم المستخدم غير صالح';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _fieldLabel('كلمة المرور'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleLogin(),
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: '••••••••',
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.textHint,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textHint,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل كلمة المرور';
              }
              if (value.length > 256) {
                return 'كلمة المرور طويلة جدًا';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'لإعادة تعيين كلمة المرور، تواصل مع مدير النظام.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    )
                  : const Text('تسجيل الدخول', style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildFooter() {
    return const Text(
      'يتم إعداد حساب المدير عند أول تشغيل فقط.',
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
    );
  }
}
