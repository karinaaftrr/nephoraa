import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../dashboard.dart';
import 'riwayat_hd_oktober.dart';

class RiwayatHdNovemberPage extends StatelessWidget {
  const RiwayatHdNovemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 24, 8),
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
                    'Riwayat HD',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
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
                      value: 'November',
                      items: const ['Oktober', 'November'],
                      onChanged: (val) {
                        if (val == 'Oktober') {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, _, _) =>
                                  const RiwayatHdOktoberPage(),
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
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSummaryCard(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/robot_riwayat.png',
                      width: 160,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Data Belum Lengkap',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Beberapa data pemantauan bulan\nini belum tersedia.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        height: 1.35,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NephoraNavbar(currentIndex: 1),
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

  Widget _buildSummaryCard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          height: 114,
          decoration: BoxDecoration(
            color: const Color(0xFFB3D3D4),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5),
          height: 114,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1A4B4E),
                Color(0xFF286C70),
                Color(0xFF399195),
              ],
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Sesi Bulan Ini',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sesi',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 70, color: Colors.white54),
              const SizedBox(width: 22),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rata-rata Durasi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Jam',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
