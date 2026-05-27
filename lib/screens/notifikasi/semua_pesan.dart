import 'package:flutter/material.dart';
import 'belum_dibaca.dart';

class SemuaPesanScreen extends StatefulWidget {
  const SemuaPesanScreen({super.key});

  @override
  State<SemuaPesanScreen> createState() => _SemuaPesanScreenState();
}

class _SemuaPesanScreenState extends State<SemuaPesanScreen> {
  // Toggle this to show empty state vs messages state
  final bool _hasMessages = false;

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
                // Active: Semua
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
                        Icon(Icons.mail_outline_rounded, color: primaryTeal, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Semua',
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
                const SizedBox(width: 12),
                // Inactive: Belum Dibaca
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const BelumDibacaScreen(),
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
                          Icon(Icons.mark_email_unread_outlined, color: textGrey, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Belum Dibaca',
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
              ],
            ),
          ),
          // Content
          Expanded(
            child: _hasMessages ? _buildMessagesList() : _buildEmptyState(),
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
            // Empty state illustration - Bell with "no messages" visual
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _EmptyNotificationPainter(),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Belum ada pesan',
              style: TextStyle(
                color: textDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pesan dan notifikasi penting akan\nmuncul di sini. Tetap pantau ya!',
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

  Widget _buildMessagesList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildNotificationItem(
          icon: Icons.campaign_rounded,
          iconBgColor: const Color(0xFFFEF3C7),
          iconColor: const Color(0xFFD97706),
          title: 'Promo Spesial!',
          subtitle:
              'Dapatkan diskon 50% untuk fitur premium selama 3 bulan. Jangan lewatkan!',
          time: '2 jam lalu',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Icons.update_rounded,
          iconBgColor: const Color(0xFFE0F2FE),
          iconColor: const Color(0xFF0284C7),
          title: 'Pembaruan Aplikasi',
          subtitle:
              'Versi terbaru Atur Uang telah tersedia. Update sekarang untuk fitur baru!',
          time: '5 jam lalu',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Icons.check_circle_outline_rounded,
          iconBgColor: const Color(0xFFDCFCE7),
          iconColor: const Color(0xFF15803D),
          title: 'Transaksi Berhasil',
          subtitle: 'Pencatatan pengeluaran sebesar Rp150.000 telah berhasil disimpan.',
          time: 'Kemarin',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.info_outline_rounded,
          iconBgColor: const Color(0xFFF1F5F9),
          iconColor: const Color(0xFF475569),
          title: 'Tips Keuangan',
          subtitle:
              'Sisihkan 20% dari pemasukan untuk tabungan darurat. Mulai dari sekarang!',
          time: '2 hari lalu',
          isUnread: false,
        ),
        _buildNotificationItem(
          icon: Icons.warning_amber_rounded,
          iconBgColor: const Color(0xFFFEE2E2),
          iconColor: const Color(0xFFB91C1C),
          title: 'Peringatan Pengeluaran',
          subtitle:
              'Pengeluaran bulan ini sudah melebihi 80% dari budget yang ditetapkan.',
          time: '3 hari lalu',
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF0FDFA) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread ? const Color(0xFF0F9F90).withAlpha(30) : const Color(0xFFE2E8F0),
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
                        style: TextStyle(
                          color: textDark,
                          fontSize: 14,
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isUnread)
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

// Custom painter for empty notification state illustration
class _EmptyNotificationPainter extends CustomPainter {
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

    // Bell body
    final bellPaint = Paint()
      ..color = const Color(0xFF0F9F90)
      ..style = PaintingStyle.fill;

    // Bell shape
    final bellPath = Path();
    bellPath.moveTo(w * 0.32, h * 0.52);
    bellPath.quadraticBezierTo(w * 0.32, h * 0.28, w * 0.5, h * 0.26);
    bellPath.quadraticBezierTo(w * 0.68, h * 0.28, w * 0.68, h * 0.52);
    bellPath.lineTo(w * 0.72, h * 0.58);
    bellPath.lineTo(w * 0.28, h * 0.58);
    bellPath.close();
    canvas.drawPath(bellPath, bellPaint);

    // Bell top knob
    canvas.drawCircle(Offset(w * 0.5, h * 0.25), 4, bellPaint);

    // Bell bottom clapper
    final clapperPaint = Paint()
      ..color = const Color(0xFFFDBA74)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.62), 6, clapperPaint);

    // "Zzz" sleep indicators for no messages

    final textPainter1 = TextPainter(
      text: TextSpan(
        text: 'z',
        style: TextStyle(
          color: const Color(0xFF94A3B8).withAlpha(200),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout();
    textPainter1.paint(canvas, Offset(w * 0.64, h * 0.22));

    final textPainter2 = TextPainter(
      text: TextSpan(
        text: 'z',
        style: TextStyle(
          color: const Color(0xFF94A3B8).withAlpha(150),
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();
    textPainter2.paint(canvas, Offset(w * 0.70, h * 0.16));

    final textPainter3 = TextPainter(
      text: TextSpan(
        text: 'z',
        style: TextStyle(
          color: const Color(0xFF94A3B8).withAlpha(100),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter3.layout();
    textPainter3.paint(canvas, Offset(w * 0.74, h * 0.12));

    // Small decorative dots
    final dotPaint = Paint()
      ..color = const Color(0xFF0F9F90).withAlpha(40)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.22, h * 0.30), 4, dotPaint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.42), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.18, h * 0.55), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.82, h * 0.28), 5, dotPaint);

    // "No message" line indicators below bell
    final linePaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(w * 0.36, h * 0.70), Offset(w * 0.64, h * 0.70), linePaint);
    canvas.drawLine(
        Offset(w * 0.40, h * 0.76), Offset(w * 0.60, h * 0.76), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
