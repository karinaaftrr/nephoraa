import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

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
                    'Tentang Aplikasi',
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
                            'assets/images/icon_nephora_app.png',
                            width: 52,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nephora',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Versi 1.0.0',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 10.5,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Nephora adalah aplikasi kesehatan yang membantu Anda memantau, menganalisis, dan menjaga kesehatan ginjal dengan bantuan teknologi AI.',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    height: 1.35,
                                    color: Color(0xFF555555),
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
                                  'Misi Kami',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF12606A),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Memberdayakan setiap individu untuk hidup lebih sehat dengan memberikan informasi, analisis, dan pendampingan, kesehatan ginjal yang personal, akurat, dan mudah diakses.',
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
                    const SizedBox(height: 16),
                    const Text(
                      'Nephora Menyediakan',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF12606A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Column(
                        children: [
                          _buildFeatureRow(
                            icon: Icons.show_chart_rounded,
                            title: 'Pemantauan Kesehatan',
                            subtitle:
                                'Pantau data kesehatan ginjal Anda secara rutin.',
                          ),
                          const Divider(height: 1, color: Color(0xFFF0F0F0)),
                          _buildFeatureRow(
                            icon: Icons.smart_toy_outlined,
                            title: 'Analisis AI',
                            subtitle: 'Dapatkan analisis kesehatan ginjal Anda.',
                          ),
                          const Divider(height: 1, color: Color(0xFFF0F0F0)),
                          _buildFeatureRow(
                            icon: Icons.menu_book_rounded,
                            title: 'Edukasi Kesehatan',
                            subtitle:
                                'Pelajari informasi dan tips kesehatan ginjal.',
                          ),
                          const Divider(height: 1, color: Color(0xFFF0F0F0)),
                          _buildFeatureRow(
                            icon: Icons.notifications_active_outlined,
                            title: 'Pengingat & Notifikasi',
                            subtitle:
                                'Kontrol kesehatan dengan pengingat & notifikasi',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF6F7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFF12606A),
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Nephora bukan pengganti diagnosis dokter. Selalu konsultasikan kondisi kesehatan Anda dengan tenaga medis profesional.',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 11.5,
                                height: 1.35,
                                color: Color(0xFF7B8189),
                              ),
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

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEBF6F7),
              borderRadius: BorderRadius.circular(10),
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
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 11.5,
                    color: Color(0xFF444444),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
