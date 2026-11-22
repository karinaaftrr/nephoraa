import 'package:flutter/material.dart';
import '../FiturHD/PantauHD/pantau_hd_oktober.dart';
import '../FiturHD/RiwayatHD/riwayat_hd_oktober.dart';
import '../FiturHD/Setelan/pengaturan_page.dart';
import '../FiturHD/dashboard.dart';

class NephoraNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const NephoraNavbar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static const List<_NavItemData> _items = [
    _NavItemData(label: 'Beranda'),
    _NavItemData(label: 'Riwayat HD'),
    _NavItemData(label: 'Pantau HD'),
    _NavItemData(label: 'Setelan'),
  ];

  void _handleItemTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const DashboardPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const RiwayatHdOktoberPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const PantauHdOktoberPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const PengaturanPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 360;
          final circleSize = isCompact ? 44.0 : 50.0;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              isCompact ? 14 : 24,
              6,
              isCompact ? 14 : 24,
              14,
            ),
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_items.length, (index) {
                  final isSelected = index == currentIndex;
                  final item = _items[index];

                  if (isSelected) {
                    return Flexible(
                      child: GestureDetector(
                        onTap: () => _handleItemTap(context, index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          height: 52,
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompact ? 12 : 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF122E2F),
                                Color(0xFF1E4C4E),
                                Color(0xFF399195),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildNavIcon(index, true),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  item.label,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => _handleItemTap(context, index),
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: _buildNavIcon(index, false),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavIcon(int index, bool isSelected) {
    final color = isSelected ? Colors.white : Colors.black87;
    switch (index) {
      case 0:
        return Icon(Icons.home_outlined, color: color, size: 24);
      case 1:
        return CustomPaint(
          size: const Size(22, 22),
          painter: _RiwayatIconPainter(color: color),
        );
      case 2:
        return CustomPaint(
          size: const Size(24, 24),
          painter: _RobotIconPainter(color: color),
        );
      case 3:
      default:
        return Icon(Icons.settings_outlined, color: color, size: 23);
    }
  }
}

class _NavItemData {
  final String label;
  const _NavItemData({required this.label});
}

class _RiwayatIconPainter extends CustomPainter {
  final Color color;
  const _RiwayatIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final docPath = Path()
      ..moveTo(size.width * 0.45, size.height * 0.82)
      ..lineTo(size.width * 0.22, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.14,
        size.height * 0.82,
        size.width * 0.14,
        size.height * 0.72,
      )
      ..lineTo(size.width * 0.14, size.height * 0.22)
      ..quadraticBezierTo(
        size.width * 0.14,
        size.height * 0.12,
        size.width * 0.24,
        size.height * 0.12,
      )
      ..lineTo(size.width * 0.68, size.height * 0.12)
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.12,
        size.width * 0.78,
        size.height * 0.22,
      )
      ..lineTo(size.width * 0.78, size.height * 0.52);
    canvas.drawPath(docPath, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.30),
      Offset(size.width * 0.64, size.height * 0.30),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.46),
      Offset(size.width * 0.56, size.height * 0.46),
      strokePaint,
    );

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final tagPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.64)
      ..lineTo(size.width * 0.72, size.height * 0.64)
      ..lineTo(size.width * 0.88, size.height * 0.78)
      ..lineTo(size.width * 0.72, size.height * 0.92)
      ..lineTo(size.width * 0.35, size.height * 0.92)
      ..lineTo(size.width * 0.48, size.height * 0.78)
      ..close();
    canvas.drawPath(tagPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _RiwayatIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _RobotIconPainter extends CustomPainter {
  final Color color;
  const _RobotIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.16),
      1.8,
      fillPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.18),
      Offset(size.width * 0.5, size.height * 0.32),
      strokePaint,
    );

    final headRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.20,
        size.height * 0.34,
        size.width * 0.60,
        size.height * 0.48,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(headRect, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.12, size.height * 0.50),
      Offset(size.width * 0.12, size.height * 0.66),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.88, size.height * 0.50),
      Offset(size.width * 0.88, size.height * 0.66),
      strokePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.38, size.height * 0.56),
      1.8,
      fillPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.56),
      1.8,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RobotIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
