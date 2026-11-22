import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'verify_account_page.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _noRmController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _noRmController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    final isMatched = await AuthService.verifyUser(
      noRm: _noRmController.text,
      phone: _phoneController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (isMatched) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyAccountPage(
            noRm: _noRmController.text.trim(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data akun tidak ditemukan. Pastikan Nomor Rekam Medis dan nomor telepon sudah benar.',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
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
                      'Ganti Password',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Masukkan Nomor Rekam Medis dan nomor telepon Anda untuk mengganti kata sandi',
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
                      label: 'Nomor Rekam Medis',
                      hintText: 'Masukkan Nomor Rekam Medis',
                      controller: _noRmController,
                      keyboardType: TextInputType.text,
                      validator: AuthService.validateNoRm,
                    ),
                    const SizedBox(height: 18),
                    NephoraAuthTextField(
                      label: 'Nomor Telepon',
                      hintText: 'Masukkan Nomor Telepon',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 15,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: AuthService.validatePhone,
                    ),
                    const SizedBox(height: 32),
                    NephoraAuthButton(
                      text: 'Lanjutkan',
                      isLoading: _isLoading,
                      onPressed: _handleVerify,
                    ),
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
