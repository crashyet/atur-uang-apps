import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Financial visibility state
  bool _totalAssetVisible = true;
  bool _tunaiVisible = true;
  bool _bankVisible = true;

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Row(
                      children: [
                        // Profile Avatar
                        Container(
                          width: 46,
                          height: 46,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0F2FE),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF0284C7),
                              size: 26,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Owner Greeting
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Halo, Owner',
                              style: TextStyle(
                                color: textGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Patra Asri',
                              style: TextStyle(
                                color: textDark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Notification Bell with Badge
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/notifikasi');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: borderGrey),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF475569),
                            size: 24,
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Total Asset Gradient Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0F9F90), // Green-teal
                      Color(0xFF14B8A6), // Lighter teal
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF14B8A6).withAlpha(50),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Abstract decorative circles on the right side
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(20),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: -40,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(15),
                        ),
                      ),
                    ),
                    // Card contents
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Total Aset',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _totalAssetVisible = !_totalAssetVisible;
                                  });
                                },
                                child: Icon(
                                  _totalAssetVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white.withAlpha(200),
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _totalAssetVisible ? 'Rp10.654.258' : 'Rp ••••••••',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Side-by-side white sub-cards
                          Row(
                            children: [
                              // Left: Pemasukan
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFDCFCE7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_upward_rounded,
                                          color: Color(0xFF15803D),
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _totalAssetVisible ? 'Rp10.654.258' : 'Rp ••••',
                                              style: const TextStyle(
                                                color: textDark,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            const Text(
                                              'Pemasukan',
                                              style: TextStyle(
                                                color: textGrey,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Right: Pengeluaran
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFEE2E2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_downward_rounded,
                                          color: Color(0xFFB91C1C),
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _totalAssetVisible ? 'Rp10.654.258' : 'Rp ••••',
                                              style: const TextStyle(
                                                color: textDark,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            const Text(
                                              'Pengeluaran',
                                              style: TextStyle(
                                                color: textGrey,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 3. Kas dan Aset Kamu Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kas dan Aset Kamu',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/jenis_dana');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Liat Semua Akun >',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Horizontal Account Slider
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    // Card 1: Tunai
                    _buildAccountCard(
                      title: 'Tunai',
                      balance: 'Rp10.654.258',
                      income: 'Rp10.654.258',
                      expense: 'Rp10.654.258',
                      isVisible: _tunaiVisible,
                      onToggleVisibility: () {
                        setState(() {
                          _tunaiVisible = !_tunaiVisible;
                        });
                      },
                    ),
                    const SizedBox(width: 14),
                    // Card 2: Bank Mandiri (overlapping/scrollable preview)
                    _buildAccountCard(
                      title: 'Bank Mandiri',
                      balance: 'Rp25.430.000',
                      income: 'Rp15.200.000',
                      expense: 'Rp4.800.000',
                      isVisible: _bankVisible,
                      onToggleVisibility: () {
                        setState(() {
                          _bankVisible = !_bankVisible;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 4. Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(
                    label: 'Laporan',
                    icon: Icons.assessment_outlined,
                    onTap: () {
                      Navigator.pushNamed(context, '/laporan');
                    },
                  ),
                  _buildQuickAction(
                    label: 'Analisa',
                    icon: Icons.pie_chart_outline_rounded,
                    onTap: () {
                      Navigator.pushNamed(context, '/analisa');
                    },
                  ),
                  _buildQuickAction(
                    label: 'Riwayat',
                    icon: Icons.history_toggle_off_rounded,
                    onTap: () {
                      Navigator.pushNamed(context, '/riwayat');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 5. Marketing Card with Custom Vector Illustration
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: borderGrey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Transaksi hari ini belum\ndicatat?',
                              style: TextStyle(
                                color: textDark,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/catat_pengeluaran');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F9F90),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Catat sekarang',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Jangan sampai ada bon yang hilang. Pembukuan rapi, pantau untung jadi mudah!',
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // High-fidelity Vector Illustration Composition
                    Center(
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CustomIllustrationWidget(),
                      ),
                    ),
                    
                    // Large Catat Transaksi Button
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/catat_pengeluaran');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textDark,
                            side: const BorderSide(color: borderGrey, width: 1.5),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Catat Transaksi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required String title,
    required String balance,
    required String income,
    required String expense,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);

    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: textGrey,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            isVisible ? balance : 'Rp ••••••••',
            style: const TextStyle(
              color: textDark,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: borderGrey, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              // Upward Pemasukan
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color(0xFF15803D),
                        size: 10,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isVisible ? income : 'Rp ••••',
                            style: const TextStyle(
                              color: textDark,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Pemasukan',
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Downward Pengeluaran
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEE2E2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: Color(0xFFB91C1C),
                        size: 10,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isVisible ? expense : 'Rp ••••',
                            style: const TextStyle(
                              color: textDark,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Pengeluaran',
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const textDark = Color(0xFF1E1E1E);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7), // Elegant gold-orange pastel
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Icon(
                icon,
                color: const Color(0xFFD97706),
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: textDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Beautiful composition vector graphics class mimicking the developer avatar and 3D charts
class CustomIllustrationWidget extends StatelessWidget {
  const CustomIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background curved orange accent matching the mockup bottom curved background
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: 90,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFDBA74), // Orange-amber
                    Color(0xFFF97316),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Decorative background glowing circle
        Positioned(
          top: 10,
          left: 60,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFF7ED).withAlpha(120),
            ),
          ),
        ),

        // Vector 3D Pie Chart Graphic (on the left side of the avatar)
        Positioned(
          left: 30,
          top: 30,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: [
                // Render a small pie chart indicator
                CustomPaint(
                  size: const Size(40, 40),
                  painter: SmallPieChartPainter(),
                ),
                const SizedBox(height: 8),
                // Small mock bars
                Row(
                  children: [
                    Container(width: 14, height: 6, decoration: BoxDecoration(color: const Color(0xFFF97316), borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Container(width: 14, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Vector 3D Column Bar Chart Graphic (just behind the tablet)
        Positioned(
          right: 40,
          top: 20,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(14, const Color(0xFFFF8E42)),
                const SizedBox(width: 4),
                _buildBar(22, const Color(0xFFFDBA74)),
                const SizedBox(width: 4),
                _buildBar(30, const Color(0xFF0F9F90)),
                const SizedBox(width: 4),
                _buildBar(18, const Color(0xFFE2E8F0)),
              ],
            ),
          ),
        ),

        // The Character Avatar Widget
        Positioned(
          bottom: 0,
          child: CustomPaint(
            size: const Size(120, 130),
            painter: AvatarCharacterPainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 6,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, size.height * 0.3);
    // Draw a curved wave at the bottom
    path.quadraticBezierTo(
      size.width * 0.5,
      -10,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SmallPieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double r = size.width / 2;
    final center = Offset(r, r);
    final rect = Rect.fromCircle(center: center, radius: r);

    // Segment 1 (Orange): 60%
    final paint1 = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.fill;
    canvas.drawArc(rect, -1.57, 3.8, true, paint1);

    // Segment 2 (Yellow): 20%
    final paint2 = Paint()
      ..color = const Color(0xFFFDBA74)
      ..style = PaintingStyle.fill;
    canvas.drawArc(rect, 2.23, 1.2, true, paint2);

    // Segment 3 (Teal): 20%
    final paint3 = Paint()
      ..color = const Color(0xFF0F9F90)
      ..style = PaintingStyle.fill;
    canvas.drawArc(rect, 3.43, 1.28, true, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Drawing character: cute vector layout (Boy with glasses holding a tablet)
class AvatarCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    
    // Skin Tone
    final Paint skinPaint = Paint()
      ..color = const Color(0xFFFFDBB5)
      ..style = PaintingStyle.fill;
      
    // Yellow T-Shirt
    final Paint shirtPaint = Paint()
      ..color = const Color(0xFFFEF08A)
      ..style = PaintingStyle.fill;

    // Hair Dark Brown
    final Paint hairPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.fill;
      
    // Orange Glasses
    final Paint glassPaint = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw shirt body (base of character)
    final shirtPath = Path();
    shirtPath.moveTo(w * 0.2, h);
    shirtPath.quadraticBezierTo(w * 0.2, h * 0.65, w * 0.5, h * 0.65);
    shirtPath.quadraticBezierTo(w * 0.8, h * 0.65, w * 0.8, h);
    canvas.drawPath(shirtPath, shirtPaint);

    // Draw neck
    final neckRect = Rect.fromLTRB(w * 0.44, h * 0.55, w * 0.56, h * 0.68);
    canvas.drawRect(neckRect, skinPaint);

    // Draw face circle
    canvas.drawCircle(Offset(w * 0.5, h * 0.38), w * 0.22, skinPaint);

    // Draw ears
    canvas.drawCircle(Offset(w * 0.26, h * 0.38), w * 0.04, skinPaint);
    canvas.drawCircle(Offset(w * 0.74, h * 0.38), w * 0.04, skinPaint);

    // Draw hair block
    final hairPath = Path();
    hairPath.moveTo(w * 0.25, h * 0.35);
    hairPath.quadraticBezierTo(w * 0.25, h * 0.15, w * 0.5, h * 0.12);
    hairPath.quadraticBezierTo(w * 0.75, h * 0.15, w * 0.75, h * 0.35);
    hairPath.quadraticBezierTo(w * 0.72, h * 0.24, w * 0.5, h * 0.2);
    hairPath.quadraticBezierTo(w * 0.28, h * 0.24, w * 0.25, h * 0.35);
    canvas.drawPath(hairPath, hairPaint);
    
    // Draw hair spikes top
    final spikePath = Path();
    spikePath.moveTo(w * 0.42, h * 0.15);
    spikePath.lineTo(w * 0.48, h * 0.08);
    spikePath.lineTo(w * 0.52, h * 0.14);
    spikePath.lineTo(w * 0.58, h * 0.09);
    spikePath.lineTo(w * 0.60, h * 0.16);
    canvas.drawPath(spikePath, hairPaint);

    // Draw orange glasses
    canvas.drawCircle(Offset(w * 0.4, h * 0.38), 10, glassPaint);
    canvas.drawCircle(Offset(w * 0.6, h * 0.38), 10, glassPaint);
    // Glasses bridge
    canvas.drawLine(Offset(w * 0.48, h * 0.38), Offset(w * 0.52, h * 0.38), glassPaint);
    // Glasses temple/sides
    canvas.drawLine(Offset(w * 0.3, h * 0.38), Offset(w * 0.34, h * 0.38), glassPaint);
    canvas.drawLine(Offset(w * 0.66, h * 0.38), Offset(w * 0.7, h * 0.38), glassPaint);

    // Draw eyes dots (inside glasses)
    final eyePaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.4, h * 0.38), 2.5, eyePaint);
    canvas.drawCircle(Offset(w * 0.6, h * 0.38), 2.5, eyePaint);

    // Draw cute smiling mouth
    final mouthPaint = Paint()
      ..color = const Color(0xFF991B1B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    
    final mouthRect = Rect.fromCircle(center: Offset(w * 0.5, h * 0.46), radius: 6);
    canvas.drawArc(mouthRect, 0.1, 2.9, false, mouthPaint);

    // Draw hands holding tablet
    // Tablet (Blue rounded rectangle)
    final tabletPaint = Paint()
      ..color = const Color(0xFF0284C7)
      ..style = PaintingStyle.fill;
    final tabletBorderPaint = Paint()
      ..color = const Color(0xFF0C4A6E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
      
    final tabletPath = Path();
    tabletPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.2, h * 0.72, w * 0.8, h * 0.94),
      const Radius.circular(8),
    ));
    canvas.drawPath(tabletPath, tabletPaint);
    canvas.drawPath(tabletPath, tabletBorderPaint);

    // Draw mock graph lines on the tablet screen
    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(Offset(w * 0.3, h * 0.85), Offset(w * 0.45, h * 0.79), linePaint);
    canvas.drawLine(Offset(w * 0.45, h * 0.79), Offset(w * 0.6, h * 0.88), linePaint);
    canvas.drawLine(Offset(w * 0.6, h * 0.88), Offset(w * 0.7, h * 0.77), linePaint);

    // Hands thumbs overlay
    canvas.drawCircle(Offset(w * 0.22, h * 0.82), 6, skinPaint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.82), 6, skinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
