import 'dart:async';
import 'package:flutter/material.dart';

class TransactionArguments {
  final String type; // 'pengeluaran' or 'pemasukan'
  final String accountName;
  final String amount;
  final String sourceOfFunds;
  final String notes;
  final String date;

  TransactionArguments({
    required this.type,
    required this.accountName,
    required this.amount,
    required this.sourceOfFunds,
    required this.notes,
    required this.date,
  });
}

class InformasiScreen extends StatefulWidget {
  const InformasiScreen({super.key});

  @override
  State<InformasiScreen> createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();
    // Automatically redirect back to the homescreen after 3 seconds
    _redirectTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/homescreen', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve passed arguments
    final args = ModalRoute.of(context)?.settings.arguments as TransactionArguments? ??
        TransactionArguments(
          type: 'pengeluaran',
          accountName: 'Akun Anda',
          amount: 'Rp 100.000',
          sourceOfFunds: 'Tunai',
          notes: 'Beli Dimsum',
          date: '18 Januari 2026',
        );

    final isExpense = args.type == 'pengeluaran';
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF64748B);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F9F90), // Teal dark
              Color(0xFF14B8A6), // Teal light
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative background circles
              Positioned(
                left: -40,
                bottom: 80,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(15),
                  ),
                ),
              ),
              Positioned(
                right: -30,
                top: 100,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFDBA74).withAlpha(30), // Gold overlay
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 40,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFDBA74), // gold dot
                  ),
                ),
              ),

              // Back navigation arrow
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/homescreen', (route) => false);
                  },
                ),
              ),

              // Main content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Orange Checkmark badge overlay
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFF8E42).withAlpha(40),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFB076),
                                  Color(0xFFFF8E42),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 46,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Ticket Receipt Card
                      ClipPath(
                        clipper: TicketClipper(),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              // Top half
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 20.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Bagus!!',
                                      style: TextStyle(
                                        color: Color(0xFF0F9F90),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      isExpense
                                          ? 'Pengeluaran Berhasil dicatat'
                                          : 'Pemasukan Berhasil dicatat',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: textDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Transaksi keuangan Anda telah disimpan dengan sukses ke sistem kami.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: textGrey,
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Dashed Line Partition
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: CustomPaint(
                                  size: const Size(double.infinity, 1),
                                  painter: DashedLinePainter(),
                                ),
                              ),

                              // Bottom half
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Detail Transaksi',
                                      style: TextStyle(
                                        color: textDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildDetailRow(
                                      label: 'Sumber Dana',
                                      value: args.sourceOfFunds,
                                    ),
                                    _buildDetailRow(
                                      label: 'Jumlah',
                                      value: args.amount,
                                      valueColor: isExpense ? Colors.redAccent : const Color(0xFF0F9F90),
                                    ),
                                    _buildDetailRow(
                                      label: 'Keterangan',
                                      value: args.notes.isNotEmpty ? args.notes : '-',
                                    ),
                                    _buildDetailRow(
                                      label: 'Tanggal',
                                      value: args.date,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // // Countdown / manual dismiss message
                      // const Text(
                      //   'Kembali ke halaman utama dalam 3 detik...',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    const textGrey = Color(0xFF64748B);
    const textDark = Color(0xFF1E1E1E);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: textGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: textGrey,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? textDark,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cutRadius = 14.0;
    // Perforated cutout height
    final cutY = size.height * 0.45;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cutY - cutRadius);
    // Right cutout inward arc
    path.arcToPoint(
      Offset(size.width, cutY + cutRadius),
      radius: Radius.circular(cutRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, cutY + cutRadius);
    // Left cutout inward arc
    path.arcToPoint(
      Offset(0, cutY - cutRadius),
      radius: Radius.circular(cutRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double startX = 0;
    const double dashWidth = 5;
    const double dashSpace = 4;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
