import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../dashboard.dart';
import 'pantau_hd_november.dart';

class PantauHdOktoberPage extends StatelessWidget {
  const PantauHdOktoberPage({super.key});

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
                            builder: (_) => const DashboardPage(),
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
                    'Pantau HD',
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
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/banner_pantau_hd.png',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              value: '2026',
                              items: const ['2026'],
                              onChanged: (_) {},
                            ),
                          ),
                          const SizedBox(width: 28),
                          Expanded(
                            child: _buildDropdown(
                              value: 'Oktober',
                              items: const ['Oktober', 'November'],
                              onChanged: (val) {
                                if (val == 'November') {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, _, _) =>
                                          const PantauHdNovemberPage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Image.asset(
                        'assets/images/grafik_tekanan_darah.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ringkasan AI',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 13,
                                height: 1.45,
                                color: Color(0xFF333333),
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Selama bulan ini, AI menganalisis data hemodialisis yang telah tercatat dan menunjukkan bahwa kondisi pasien relatif ',
                                ),
                                TextSpan(
                                  text: 'tidak stabil.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E4C4E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildInfoCard(
                            title: 'Faktor Pendukung',
                            backgroundColor: const Color(0xFF3A7BF2),
                            useCheckIcon: true,
                            items: const [
                              'Seluruh sesi hemodialisis terlaksana sesuai jadwal',
                              'Berat badan antar sesi HD berada dalam rentang stabil',
                              'Tekanan darah menunjukkan pola yang relatif terkontrol',
                            ],
                          ),
                          const SizedBox(width: 12),
                          _buildInfoCard(
                            title: 'Faktor Penghambat',
                            backgroundColor: const Color(0xFF008B94),
                            useCheckIcon: false,
                            items: const [
                              'Kenaikan berat badan antar sesi terkadang melebihi batas',
                              'Fluktuasi tekanan darah sistolik pada beberapa sesi HD',
                              'Asupan cairan harian yang belum sepenuhnya konsisten',
                            ],
                          ),
                          const SizedBox(width: 12),
                          _buildInfoCard(
                            title: 'Hal yang Perlu Diperhatikan',
                            backgroundColor: const Color(0xFF1E4C4E),
                            useCheckIcon: false,
                            items: const [
                              'Batasi asupan cairan harian sesuai target (2,5 Liter)',
                              'Pantau tekanan darah rutin sebelum dan sesudah sesi HD',
                              'Kurangi konsumsi makanan tinggi garam dan kalium',
                            ],
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
      bottomNavigationBar: const NephoraNavbar(currentIndex: 2),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFC7E2E3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFFEAF4F4),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: Color(0xFF1E4C4E),
          ),
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E4C4E),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Color backgroundColor,
    required bool useCheckIcon,
    required List<String> items,
  }) {
    return Container(
      width: 315,
      height: 168,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -4,
            bottom: -4,
            child: Image.asset(
              'assets/images/robot_faktor.png',
              width: 88,
              height: 108,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 72, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ...items.map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: useCheckIcon
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11.5,
                              height: 1.3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
