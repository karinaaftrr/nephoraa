import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../../services/auth_service.dart';
import 'konfirmasi_ubah_sandi_page.dart';

class UbahKataSandiBaruPage extends StatefulWidget {
  const UbahKataSandiBaruPage({super.key});

  @override
  State<UbahKataSandiBaruPage> createState() => _UbahKataSandiBaruPageState();
}

class _UbahKataSandiBaruPageState extends State<UbahKataSandiBaruPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    final error = AuthService.validateStrongPassword(newPass);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi kata sandi baru tidak sama.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await AuthService.resetPassword(newPassword: newPass);
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const KonfirmasiUbahSandiPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 24, 6),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text(
                    'Ubah Kata Sandi',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(26, 28, 26, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordInput(
                                label: 'Kata Sandi Baru',
                                hintText: 'Masukan Kata Sandi Baru',
                                controller: _newPasswordController,
                                obscureText: _obscureNew,
                                onToggle: () {
                                  setState(() => _obscureNew = !_obscureNew);
                                },
                              ),
                              const SizedBox(height: 18),
                              _buildPasswordInput(
                                label: 'Konfirmasi Kata Sandi Baru',
                                hintText: 'Masukan Kata Sandi Kembali',
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirm,
                                onToggle: () {
                                  setState(
                                    () => _obscureConfirm = !_obscureConfirm,
                                  );
                                },
                              ),
                              const Spacer(),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _handleSave,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF138896),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Simpan Perubahan',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NephoraNavbar(currentIndex: 3),
    );
  }

  Widget _buildPasswordInput({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.5,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              color: Color(0xFFB5B5B5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF12606A),
                size: 21,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF138896),
                width: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
