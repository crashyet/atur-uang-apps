import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalisaScreen extends StatefulWidget {
  const AnalisaScreen({super.key});

  @override
  State<AnalisaScreen> createState() => _AnalisaScreenState();
}

class _AnalisaScreenState extends State<AnalisaScreen> {
  // Tab state: 0 = Transaksi (Keseluruhan), 1 = Analisis Per Akun
  int _selectedTab = 0;

  // Month picker
  String _selectedMonth = 'Januari 2025';
  final List<String> _months = [
    'Januari 2025',
    'Februari 2025',
    'Maret 2025',
    'April 2025',
    'Mei 2025',
    'Juni 2025',
    'Juli 2025',
    'Agustus 2025',
    'September 2025',
    'Oktober 2025',
    'November 2025',
    'Desember 2025',
  ];

  // Page controller for per-account swiping
  late PageController _pageController;
  int _currentAccountPage = 0;

  // Sample account data for Analisis Per Akun
  final List<_AccountAnalysis> _accounts = [
    _AccountAnalysis(
      name: 'BNI',
      totalAmount: 'Rp.1.385.000',
      pengeluaranPercent: 97,
      pemasukanPercent: 3,
      topPengeluaran: _CategoryItem(
        icon: Icons.inventory_2_outlined,
        title: 'Biaya Produksi',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFFDC2626),
      ),
      topPemasukan: _CategoryItem(
        icon: Icons.handyman_outlined,
        title: 'Penjualan Jasa',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFF0F9F90),
      ),
    ),
    _AccountAnalysis(
      name: 'Tunai',
      totalAmount: 'Rp.1.385.000',
      pengeluaranPercent: 97,
      pemasukanPercent: 3,
      topPengeluaran: _CategoryItem(
        icon: Icons.inventory_2_outlined,
        title: 'Biaya Produksi',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFFDC2626),
      ),
      topPemasukan: _CategoryItem(
        icon: Icons.handyman_outlined,
        title: 'Penjualan Jasa',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFF0F9F90),
      ),
    ),
    _AccountAnalysis(
      name: 'BRI',
      totalAmount: 'Rp.1.385.000',
      pengeluaranPercent: 97,
      pemasukanPercent: 3,
      topPengeluaran: _CategoryItem(
        icon: Icons.inventory_2_outlined,
        title: 'Biaya Produksi',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFFDC2626),
      ),
      topPemasukan: _CategoryItem(
        icon: Icons.handyman_outlined,
        title: 'Penjualan Jasa',
        percent: 100,
        amount: 'Rp 100.000,00',
        color: const Color(0xFF0F9F90),
      ),
    ),
  ];

  // Overall analysis data (Keseluruhan Akun)
  final _AccountAnalysis _overallAnalysis = _AccountAnalysis(
    name: 'Keseluruhan Akun',
    totalAmount: 'Rp.1.385.000',
    pengeluaranPercent: 97,
    pemasukanPercent: 3,
    topPengeluaran: _CategoryItem(
      icon: Icons.inventory_2_outlined,
      title: 'Biaya Produksi (BNI)',
      percent: 100,
      amount: 'Rp 100.000,00',
      color: const Color(0xFFDC2626),
    ),
    topPemasukan: _CategoryItem(
      icon: Icons.handyman_outlined,
      title: 'Penjualan Jasa (Tunai)',
      percent: 100,
      amount: 'Rp 100.000,00',
      color: const Color(0xFF0F9F90),
    ),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
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
          'Analisa',
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
          // Tab selector & month picker
          _buildTabAndMonthRow(),
          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildKeseluruhanContent()
                : _buildPerAkunContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabAndMonthRow() {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const primaryTeal = Color(0xFF0F9F90);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          // Left side: Transaksi label + Month picker
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transaksi',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: _showMonthPicker,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedMonth,
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: textDark,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Right side: Tab toggles
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = 1);
                },
                child: Text(
                  'Analisis Per Akun',
                  style: TextStyle(
                    color: _selectedTab == 1 ? primaryTeal : textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    decoration: _selectedTab == 1
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: primaryTeal,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = 0);
                },
                child: Text(
                  'Keseluruhan',
                  style: TextStyle(
                    color: _selectedTab == 0 ? primaryTeal : textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    decoration: _selectedTab == 0
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: primaryTeal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Keseluruhan Content (Tab 0) ───────────────────────
  Widget _buildKeseluruhanContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _buildAnalysisCard(_overallAnalysis),
    );
  }

  // ─── Per Akun Content (Tab 1) ──────────────────────────
  Widget _buildPerAkunContent() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _accounts.length,
            onPageChanged: (index) {
              setState(() => _currentAccountPage = index);
            },
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: _buildAnalysisCard(_accounts[index]),
              );
            },
          ),
        ),
        // Page indicator dots
        _buildPageIndicator(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _accounts.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentAccountPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentAccountPage == index
                ? const Color(0xFF0F9F90)
                : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  // ─── Shared Analysis Card ──────────────────────────────
  Widget _buildAnalysisCard(_AccountAnalysis analysis) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Account name header
        Center(
          child: Text(
            analysis.name,
            style: const TextStyle(
              color: textDark,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Donut chart
        Center(
          child: SizedBox(
            width: 220,
            height: 220,
            child: CustomPaint(
              painter: _DonutChartPainter(
                pengeluaranPercent: analysis.pengeluaranPercent.toDouble(),
                pemasukanPercent: analysis.pemasukanPercent.toDouble(),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      analysis.totalAmount,
                      style: const TextStyle(
                        color: textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.trending_up_rounded,
                          color: Color(0xFF0F9F90),
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Keuntungan',
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Percentage labels on sides
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${analysis.pengeluaranPercent}%',
                style: const TextStyle(
                  color: textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${analysis.pemasukanPercent}%',
                style: const TextStyle(
                  color: Color(0xFFDC2626),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendDot(const Color(0xFFDC2626), 'Pengeluaran'),
            const SizedBox(width: 24),
            _buildLegendDot(const Color(0xFF0F9F90), 'Pemasukan'),
          ],
        ),
        const SizedBox(height: 28),

        // Divider
        Container(
          height: 1,
          color: const Color(0xFFE2E8F0),
        ),
        const SizedBox(height: 20),

        // Kategori Pengeluaran Terbanyak
        const Text(
          'Kategori Pengeluaran Terbanyak',
          style: TextStyle(
            color: textDark,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        _buildCategoryRow(analysis.topPengeluaran, isExpense: true),
        const SizedBox(height: 24),

        // Kategori Pemasukkan Terbanyak
        const Text(
          'Kategori Pemasukkan Terbanyak',
          style: TextStyle(
            color: textDark,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        _buildCategoryRow(analysis.topPemasukan, isExpense: false),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A7A7A),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(_CategoryItem item, {required bool isExpense}) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isExpense
                  ? const Color(0xFFFEE2E2)
                  : const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: isExpense
                  ? const Color(0xFFDC2626)
                  : const Color(0xFF0F9F90),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Title & percentage
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.percent}%',
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            item.amount,
            style: TextStyle(
              color: isExpense
                  ? const Color(0xFFDC2626)
                  : const Color(0xFF0F9F90),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthPicker() {
    const textDark = Color(0xFF1E1E1E);
    const primaryTeal = Color(0xFF0F9F90);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pilih Bulan',
                style: TextStyle(
                  color: textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _months.length,
                  itemBuilder: (context, index) {
                    final month = _months[index];
                    final isSelected = month == _selectedMonth;
                    return InkWell(
                      onTap: () {
                        setState(() => _selectedMonth = month);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        color: isSelected
                            ? primaryTeal.withAlpha(10)
                            : Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              month,
                              style: TextStyle(
                                color: isSelected ? primaryTeal : textDark,
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_rounded,
                                color: primaryTeal,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }
}

// ─── Donut Chart Custom Painter ────────────────────────────
class _DonutChartPainter extends CustomPainter {
  final double pengeluaranPercent;
  final double pemasukanPercent;

  _DonutChartPainter({
    required this.pengeluaranPercent,
    required this.pemasukanPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 24.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track
    final bgPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Pemasukan arc (teal) - starts from top
    final total = pengeluaranPercent + pemasukanPercent;
    final pemasukanSweep = (pemasukanPercent / total) * 2 * math.pi;
    final pengeluaranSweep = (pengeluaranPercent / total) * 2 * math.pi;

    // Draw pengeluaran arc (teal) - majority
    final pengeluaranPaint = Paint()
      ..color = const Color(0xFF0F9F90)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from top (-π/2), draw pengeluaran sweep
    canvas.drawArc(
      rect,
      -math.pi / 2,
      pengeluaranSweep,
      false,
      pengeluaranPaint,
    );

    // Draw pemasukan arc (red)
    final pemasukanPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2 + pengeluaranSweep,
      pemasukanSweep,
      false,
      pemasukanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.pengeluaranPercent != pengeluaranPercent ||
        oldDelegate.pemasukanPercent != pemasukanPercent;
  }
}

// ─── Data Models ───────────────────────────────────────────
class _AccountAnalysis {
  final String name;
  final String totalAmount;
  final int pengeluaranPercent;
  final int pemasukanPercent;
  final _CategoryItem topPengeluaran;
  final _CategoryItem topPemasukan;

  const _AccountAnalysis({
    required this.name,
    required this.totalAmount,
    required this.pengeluaranPercent,
    required this.pemasukanPercent,
    required this.topPengeluaran,
    required this.topPemasukan,
  });
}

class _CategoryItem {
  final IconData icon;
  final String title;
  final int percent;
  final String amount;
  final Color color;

  const _CategoryItem({
    required this.icon,
    required this.title,
    required this.percent,
    required this.amount,
    required this.color,
  });
}
