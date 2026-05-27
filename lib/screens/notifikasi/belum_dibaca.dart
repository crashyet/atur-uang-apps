import 'package:flutter/material.dart';
import 'semua_pesan.dart';

class BelumDibacaScreen extends StatefulWidget {
  const BelumDibacaScreen({super.key});

  @override
  State<BelumDibacaScreen> createState() => _BelumDibacaScreenState();
}

class _BelumDibacaScreenState extends State<BelumDibacaScreen> {
  // Toggle this to show empty state vs unread messages
  final bool _hasUnreadMessages = false;

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const primaryTeal = Color(0xFF0F9F90);
    const borderGrey = Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: textDark,
        ),
        centerTitle: true,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: borderGrey),
          // Pill-style toggle buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                // Inactive: Semua
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const SemuaPesanScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                        ),
                      );
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: borderGrey, width: 1.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.mail_outline_rounded, color: textGrey, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Semua',
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Active: Belum Dibaca
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDFA),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: primaryTeal, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mark_email_unread_outlined, color: primaryTeal, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Belum Dibaca',
                          style: TextStyle(
                            color: primaryTeal,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _hasUnreadMessages ? _buildUnreadList() : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration - Envelope with checkmark
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _EmptyUnreadPainter(),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Semua sudah dibaca!',
              style: TextStyle(
                color: textDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tidak ada pesan yang belum dibaca.\nKamu sudah up-to-date!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textGrey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnreadList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildUnreadItem(
          icon: Icons.campaign_rounded,
          iconBgColor: const Color(0xFFFEF3C7),
          iconColor: const Color(0xFFD97706),
          title: 'Promo Spesial!',
          subtitle:
              'Dapatkan diskon 50% untuk fitur premium selama 3 bulan. Jangan lewatkan!',
          time: '2 jam lalu',
        ),
        _buildUnreadItem(
          icon: Icons.update_rounded,
          iconBgColor: const Color(0xFFE0F2FE),
          iconColor: const Color(0xFF0284C7),
          title: 'Pembaruan Aplikasi',
          subtitle:
              'Versi terbaru Atur Uang telah tersedia. Update sekarang untuk fitur baru!',
          time: '5 jam lalu',
        ),
      ],
    );
  }

  Widget _buildUnreadItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF0F9F90).withAlpha(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F9F90),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: TextStyle(
                    color: textGrey.withAlpha(180),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
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

// Custom painter for empty unread state illustration
class _EmptyUnreadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);

    // Background soft circle
    final bgPaint = Paint()
      ..color = const Color(0xFFF0FDFA)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, w * 0.42, bgPaint);

    // Outer ring
    final ringPaint = Paint()
      ..color = const Color(0xFF0F9F90).withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, w * 0.42, ringPaint);

    // Envelope body
    final envelopePaint = Paint()
      ..color = const Color(0xFF0F9F90)
      ..style = PaintingStyle.fill;

    final envelopePath = Path();
    envelopePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.24, h * 0.34, w * 0.76, h * 0.64),
      const Radius.circular(8),
    ));
    canvas.drawPath(envelopePath, envelopePaint);

    // Envelope flap
    final flapPaint = Paint()
      ..color = const Color(0xFF14B8A6)
      ..style = PaintingStyle.fill;

    final flapPath = Path();
    flapPath.moveTo(w * 0.24, h * 0.38);
    flapPath.lineTo(w * 0.50, h * 0.52);
    flapPath.lineTo(w * 0.76, h * 0.38);
    flapPath.lineTo(w * 0.76, h * 0.34);
    flapPath.lineTo(w * 0.24, h * 0.34);
    flapPath.close();
    canvas.drawPath(flapPath, flapPaint);

    // White lines on envelope
    final whiteLine = Paint()
      ..color = Colors.white.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(w * 0.34, h * 0.52), Offset(w * 0.56, h * 0.52), whiteLine);
    canvas.drawLine(
        Offset(w * 0.34, h * 0.57), Offset(w * 0.48, h * 0.57), whiteLine);

    // Checkmark circle badge
    final badgePaint = Paint()
      ..color = const Color(0xFF15803D)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.68, h * 0.34), 14, badgePaint);

    // White checkmark
    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final checkPath = Path();
    checkPath.moveTo(w * 0.63, h * 0.34);
    checkPath.lineTo(w * 0.67, h * 0.38);
    checkPath.lineTo(w * 0.74, h * 0.30);
    canvas.drawPath(checkPath, checkPaint);

    // Sparkle decorations
    final sparklePaint = Paint()
      ..color = const Color(0xFFFDBA74)
      ..style = PaintingStyle.fill;

    // Star sparkle top-right
    _drawSparkle(canvas, Offset(w * 0.78, h * 0.22), 6, sparklePaint);
    _drawSparkle(canvas, Offset(w * 0.22, h * 0.28), 4,
        sparklePaint..color = const Color(0xFF0F9F90).withAlpha(60));
    _drawSparkle(canvas, Offset(w * 0.82, h * 0.50), 3,
        sparklePaint..color = const Color(0xFF0F9F90).withAlpha(40));

    // Small decorative dots
    final dotPaint = Paint()
      ..color = const Color(0xFF0F9F90).withAlpha(40)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.18, h * 0.45), 4, dotPaint);
    canvas.drawCircle(Offset(w * 0.80, h * 0.65), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.25, h * 0.70), 3, dotPaint);
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx + size * 0.3, center.dy - size * 0.3);
    path.lineTo(center.dx + size, center.dy);
    path.lineTo(center.dx + size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx, center.dy + size);
    path.lineTo(center.dx - size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx - size, center.dy);
    path.lineTo(center.dx - size * 0.3, center.dy - size * 0.3);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
