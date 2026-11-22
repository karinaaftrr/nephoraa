import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import 'pengaturan_page.dart';

class KonfirmasiUbahSandiPage extends StatelessWidget {
  const KonfirmasiUbahSandiPage({super.key});

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
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PengaturanPage(),
                          ),
                        );
                      },
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Container(
                                width: 76,
                                height: 76,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5F4EF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF138896),
                                  size: 48,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Kata Sandi Berhasil Diperbarui',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Kata sandi baru Anda telah tersimpan di SharedPreferences dan siap digunakan untuk masuk kembali.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.5,
                                  height: 1.4,
                                  color: Color(0xFF555555),
                                ),
                              ),
                              const Spacer(),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const PengaturanPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF138896),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Kembali ke Pengaturan',
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
