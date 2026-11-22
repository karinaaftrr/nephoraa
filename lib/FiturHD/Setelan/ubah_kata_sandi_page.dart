import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../../services/auth_service.dart';
import 'ubah_kata_sandi_baru_page.dart';

class UbahKataSandiPage extends StatefulWidget {
  const UbahKataSandiPage({super.key});

  @override
  State<UbahKataSandiPage> createState() => _UbahKataSandiPageState();
}

class _UbahKataSandiPageState extends State<UbahKataSandiPage> {
  final _currentPasswordController = TextEditingController();
  bool _obscureCurrent = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    final text = _currentPasswordController.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan kata sandi Anda sekarang.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final isValid = await AuthService.verifyCurrentPassword(text);
    if (!mounted) return;

    if (isValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const UbahKataSandiBaruPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi sekarang tidak sesuai.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
                              const Text(
                                'Kata Sandi Sekarang',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _currentPasswordController,
                                obscureText: _obscureCurrent,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.5,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Masukan Kata Sandi Anda Sekarang',
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
                                    onPressed: () {
                                      setState(
                                        () =>
                                            _obscureCurrent = !_obscureCurrent,
                                      );
                                    },
                                    icon: Icon(
                                      _obscureCurrent
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: const Color(0xFF12606A),
                                      size: 21,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE5E5E5),
                                    ),
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
                              const Spacer(),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _handleNext,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF138896),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Selanjutnya',
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
}
