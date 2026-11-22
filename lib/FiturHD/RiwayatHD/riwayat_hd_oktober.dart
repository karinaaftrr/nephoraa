import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../dashboard.dart';
import 'riwayat_hd_november.dart';

class RiwayatHdOktoberPage extends StatelessWidget {
  const RiwayatHdOktoberPage({super.key});

  static const List<Map<String, String>> _sessions = [
    {
      'day': '29',
      'title': 'HD #09',
      'duration': '5j 00m',
      'volume': '2.5 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '26',
      'title': 'HD #08',
      'duration': '4j 50m',
      'volume': '2.4 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '22',
      'title': 'HD #07',
      'duration': '4j 55m',
      'volume': '2.4 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '19',
      'title': 'HD #06',
      'duration': '4j 00m',
      'volume': '2.2 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '15',
      'title': 'HD #05',
      'duration': '5j 00m',
      'volume': '2.5 L',
      'machine': 'Mesin 04',
    },
    {
      'day': '12',
      'title': 'HD #04',
      'duration': '4j 35m',
      'volume': '2.3 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '08',
      'title': 'HD #03',
      'duration': '4j 30m',
      'volume': '2.3 L',
      'machine': 'Mesin 05',
    },
    {
      'day': '05',
      'title': 'HD #02',
      'duration': '4j 15m',
      'volume': '2.1 L',
      'machine': 'Mesin 04',
    },
    {
      'day': '01',
      'title': 'HD #01',
      'duration': '4j 30m',
      'volume': '2.2 L',
      'machine': 'Mesin 05',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      value: 'Oktober',
                      items: const ['Oktober', 'November'],
                      onChanged: (val) {
                        if (val == 'November') {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, _, _) =>
                                  const RiwayatHdNovemberPage(),
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
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.only(left: 30, bottom: 12),
              child: Text(
                'Aktivitas Terakhir',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                itemCount: _sessions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return _buildSessionItem(_sessions[index]);
                },
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
                          '9',
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
                          '4.5',
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

  Widget _buildSessionItem(Map<String, String> item) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFC7E2E3),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['day']!,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Oktober',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '2026',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E4C4E),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 14,
                        color: Color(0xFF444444),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item['duration']!,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.5,
                          color: Color(0xFF444444),
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.water_drop_outlined,
                        size: 14,
                        color: Color(0xFF444444),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['volume']!,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.5,
                          color: Color(0xFF444444),
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.tune_rounded,
                        size: 14,
                        color: Color(0xFF444444),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          item['machine']!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.5,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
