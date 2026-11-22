import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'new_password_page.dart';

class VerifyAccountPage extends StatelessWidget {
  final String noRm;

  const VerifyAccountPage({
    super.key,
    required this.noRm,
  });

  @override
  Widget build(BuildContext context) {
    final maskedNoRm = AuthService.maskNoRm(noRm);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
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
              padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _VerifiedIdentityIllustration(),
                  const SizedBox(height: 28),
                  const Text(
                    'Data Ditemukan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Akun dengan No. Rekam Medis $maskedNoRm\nberhasil diverifikasi.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.45,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 36),
                  NephoraAuthButton(
                    text: 'Buat Kata Sandi Baru',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPasswordPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerifiedIdentityIllustration extends StatelessWidget {
  const _VerifiedIdentityIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 165,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 14,
            top: 28,
            child: Container(
              width: 110,
              height: 95,
              decoration: BoxDecoration(
                color: const Color(0xFFDFF4F7),
                borderRadius: BorderRadius.circular(52),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 18,
            child: Container(
              width: 120,
              height: 105,
              decoration: BoxDecoration(
                color: const Color(0xFFDFF4F7),
                borderRadius: BorderRadius.circular(58),
              ),
            ),
          ),
          Container(
            width: 104,
            height: 124,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF69C4BD),
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14399195),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF69C4BD),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 38,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF69C4BD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC7E7E4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC7E7E4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC7E7E4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 36,
            bottom: 12,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF5DB990),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
