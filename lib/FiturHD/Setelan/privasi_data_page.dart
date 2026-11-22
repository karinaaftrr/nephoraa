import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';

class PrivasiDataPage extends StatelessWidget {
  const PrivasiDataPage({super.key});

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
                    'Privasi & Data Kesehatan',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 12, 26, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF6F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_privasi_shield.png',
                            width: 48,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data Anda Terlindungi',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Nephora berkomitmen menjaga keamanan dan kerahasiaan data kesehatan anda',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    height: 1.35,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Kesehatan',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Nephora menyimpan dan menggunakan data berikut untuk membantu memberikan analisis dan rekomendasi yang lebih personal.',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              height: 1.35,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFF2F2F2),
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildPrivacyItem(
                                  icon: Icons.account_circle_outlined,
                                  title: 'Informasi Profil Kesehatan',
                                  subtitle:
                                      'Data dasar seperti usia, jenis kelamin, dan informasi kesehatan lainnya.',
                                ),
                                const SizedBox(height: 14),
                                _buildPrivacyItem(
                                  icon: Icons.assignment_outlined,
                                  title: 'Riwayat Data Kesehatan',
                                  subtitle:
                                      'Data pemeriksaan, catatan kesehatan, dan informasi yang anda masukkan.',
                                ),
                                const SizedBox(height: 14),
                                _buildPrivacyItem(
                                  icon: Icons.grid_view_outlined,
                                  title: 'Data untuk Analisis AI',
                                  subtitle:
                                      'Data yang digunakan untuk memberikan rekomendasi dan analisis yang lebih personal.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEBF6F7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_user_outlined,
                              color: Color(0xFF12606A),
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Penggunaan Data',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Data kesehatan Anda digunakan untuk membantu memberikan analisis, rekomendasi, pengingat, serta meningkatkan layanan Nephora agar lebih relevan dengan kondisi Anda',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    height: 1.35,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Privasi',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Data kesehatan Anda disimpan secara aman dan tidak dibagikan kepada pihak ketiga tanpa persetujuan Anda.',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              height: 1.35,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NephoraNavbar(currentIndex: 3),
    );
  }

  Widget _buildPrivacyItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFEBF6F7),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF12606A), size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11.5,
                  height: 1.3,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
