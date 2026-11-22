import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isResetSuccess = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSavePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    final updated = await AuthService.resetPassword(
      newPassword: _passwordController.text,
    );
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _isResetSuccess = updated;
    });

    if (updated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Kata sandi berhasil diperbarui. Silakan masuk menggunakan kata sandi baru Anda.',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: Color(0xFF1E4C4E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 242,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: WaveHeaderPainter(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 24,
                    right: 24,
                    bottom: 44,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_2.png',
                        width: 290,
                        height: 82,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Buat Kata Sandi Baru',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Buat kata sandi yang kuat untuk keamanan akun Anda',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 26),
                    NephoraAuthTextField(
                      label: 'Kata Sandi',
                      hintText: 'Masukkan Kata Sandi',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: AuthService.validateStrongPassword,
                    ),
                    const SizedBox(height: 18),
                    NephoraAuthTextField(
                      label: 'Konfirmasi Kata Sandi',
                      hintText: 'Masukkan Kata Sandi Kembali',
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      onToggleObscure: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi kata sandi wajib diisi';
                        }
                        if (value != _passwordController.text) {
                          return 'Konfirmasi kata sandi tidak sama';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Petunjuk Pengisian Kata Sandi Baru:',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '•  Kata sandi minimal enam karakter',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                              height: 1.45,
                            ),
                          ),
                          Text(
                            '•  Harus mengandung angka',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                              height: 1.45,
                            ),
                          ),
                          Text(
                            '•  Harus menggunakan huruf besar dan kecil',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    NephoraAuthButton(
                      text: 'Simpan Perubahan',
                      isLoading: _isLoading,
                      onPressed: _handleSavePassword,
                    ),
                    if (_isResetSuccess) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F4EF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFF5DB990),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Text(
                                'Kata sandi berhasil diperbarui.\nSilakan masuk menggunakan\nkata sandi baru Anda.',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: Color(0xFF122E2F),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
