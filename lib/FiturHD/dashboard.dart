import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../authentication/login_page.dart';
import '../navbar/navbar.dart';
import '../services/auth_service.dart';
import 'PantauHD/pantau_hd_oktober.dart';
import 'RiwayatHD/riwayat_hd_oktober.dart';
import 'Setelan/pengaturan_page.dart';

class DashboardPage extends StatefulWidget {
  final int initialTabIndex;

  const DashboardPage({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _selectedNavIndex;

  final List<_MissionItem> _missions = [
    _MissionItem(title: 'Datang tepat waktu HD', points: '+100 p', done: true),
    _MissionItem(title: 'Catat berat badan', points: '+20 p', done: true),
    _MissionItem(title: 'Catat tekanan daerah', points: '+20 p', done: false),
    _MissionItem(
      title: 'Minum sesuai target cairan',
      points: '+20 p',
      done: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedNavIndex = widget.initialTabIndex;
  }

  void _onNavbarTap(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const RiwayatHdOktoberPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      return;
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const PantauHdOktoberPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      return;
    }
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const PengaturanPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      return;
    }
    setState(() {
      _selectedNavIndex = index;
    });
  }

  Future<void> _handleLogout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        bottom: false,
        child: _selectedNavIndex == 0
            ? _buildBerandaContent()
            : _buildOtherTabContent(),
      ),
      bottomNavigationBar: NephoraNavbar(
        currentIndex: _selectedNavIndex,
        onTap: _onNavbarTap,
      ),
    );
  }

  Widget _buildBerandaContent() {
    final completedCount = _missions.where((m) => m.done).length;
    final progressRatio = completedCount / _missions.length;
    final progressPercent = (progressRatio * 100).round();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/profile_liam.png',
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Halo, Liam! ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '👋',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Bagaimana kabarmu hari ini?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8C9199),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildJadwalBannerCard(),
          const SizedBox(height: 20),
          const Text(
            'Ringkasan Terapi Terakhir',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildBeratBadanCard()),
              const SizedBox(width: 12),
              Expanded(child: _buildDurasiHdCard()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildTekananDarahCard()),
              const SizedBox(width: 12),
              Expanded(child: _buildTargetCairanCard()),
            ],
          ),
          const SizedBox(height: 20),
          _buildProgresMisiSection(
            completedCount: completedCount,
            totalCount: _missions.length,
            progressRatio: progressRatio,
            progressPercent: progressPercent,
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalBannerCard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          height: 142,
          decoration: BoxDecoration(
            color: const Color(0xFFB3D3D4),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF1A4B4E),
                Color(0xFF286C70),
                Color(0xFF399195),
              ],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal HD Berikutnya',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Kamis, 20 Agustus 2026',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RS Advent Bandar Lampung',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '09:00 WIB',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCardShell({required Widget child}) {
    return Container(
      height: 126,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBeratBadanCard() {
    return _buildSummaryCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icon_berat_badan.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Berat Badan',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pre HD',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Color(0xFFA8C6C8),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '60.78 kg',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 26,
                color: const Color(0xFFEEEEEE),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Post HD',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Color(0xFFA8C6C8),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '58.2 kg',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_downward_rounded,
                size: 14,
                color: Color(0xFF2E5B3C),
              ),
              SizedBox(width: 4),
              Text(
                '2.67 kg',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF55B959),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurasiHdCard() {
    return _buildSummaryCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icon_durasi_hd.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Durasi HD',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              '4 Jam 30 Menit',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: const Color(0xFF55B959),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'Sesuai Target',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF55B959),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTekananDarahCard() {
    return _buildSummaryCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icon_tekanan_darah.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Tekanan Darah',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pre HD',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Color(0xFFA8C6C8),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '128/82',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 26,
                color: const Color(0xFFEEEEEE),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Post HD',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Color(0xFFA8C6C8),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '120/78',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Stabil',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF55B959),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetCairanCard() {
    return _buildSummaryCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icon_target_cairan.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Target Cairan',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              '2,5 Liter',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: const Color(0xFF55B959),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'Tercapai',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF55B959),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgresMisiSection({
    required int completedCount,
    required int totalCount,
    required double progressRatio,
    required int progressPercent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 115,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Progres Agustus',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E4C4E),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: CustomPaint(
                    painter: _DonutProgressPainter(progress: progressRatio),
                    child: Center(
                      child: Text(
                        '$progressPercent%',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E4C4E),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pejuan Kesehatan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF28892B),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Terus Bertumbuh!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF122E2F),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Misi Hari Ini',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '$completedCount/$totalCount Selesai',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(_missions.length, (i) {
                    final mission = _missions[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mission.done = !mission.done;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: mission.done
                                    ? const Color(0xFF1E4C4E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                  color: mission.done
                                      ? const Color(0xFF1E4C4E)
                                      : const Color(0xFFE0E0E0),
                                  width: 1.2,
                                ),
                              ),
                              child: mission.done
                                  ? const Icon(
                                      Icons.check,
                                      size: 10,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                mission.title,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ),
                            Text(
                              mission.points,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E4C4E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard_rounded,
                          size: 20,
                          color: Color(0xFF1E4C4E),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 9.5,
                                height: 1.3,
                                color: Color(0xFF222222),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Selesaikan semua hari ini\nuntuk bonus ',
                                ),
                                TextSpan(
                                  text: '+50 care points!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF399195),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherTabContent() {
    final tabTitles = ['Beranda', 'Riwayat HD', 'Asisten AI', 'Catatan', 'Pengaturan'];
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/robot_riwayat.png',
            width: 140,
            height: 155,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'Halaman ${tabTitles[_selectedNavIndex]}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF122E2F),
            ),
          ),
          const SizedBox(height: 24),
          if (_selectedNavIndex == 4)
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: _handleLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4C4E),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Keluar Akun',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MissionItem {
  final String title;
  final String points;
  bool done;

  _MissionItem({
    required this.title,
    required this.points,
    required this.done,
  });
}

class _DonutProgressPainter extends CustomPainter {
  final double progress;
  const _DonutProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 11.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = const Color(0xFFDCDCDC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final activePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF399195),
          Color(0xFF1E4C4E),
          Color(0xFF122E2F),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
