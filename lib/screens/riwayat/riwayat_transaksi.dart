import 'package:flutter/material.dart';

class RiwayatTransaksiScreen extends StatefulWidget {
  const RiwayatTransaksiScreen({super.key});

  @override
  State<RiwayatTransaksiScreen> createState() => _RiwayatTransaksiScreenState();
}

class _RiwayatTransaksiScreenState extends State<RiwayatTransaksiScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Filter state
  String _selectedTransaksi = 'Semua';
  String _selectedSumber = 'Semua';
  String _selectedTanggal = 'Semua';

  // Sample transaction data
  final List<_TransactionItem> _allTransactions = [
    _TransactionItem(
      title: 'Beban Gaji Karyawan',
      date: '18 Januari 2026',
      amount: 'Rp. 15.000',
      type: _TransactionType.pengeluaran,
    ),
    _TransactionItem(
      title: 'Pendapatan Jasa',
      date: '18 Januari 2026',
      amount: 'Rp. 750.000',
      type: _TransactionType.pemasukan,
    ),
  ];

  List<_TransactionItem> get _filteredTransactions {
    List<_TransactionItem> results = List.from(_allTransactions);

    // Filter by search query
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      results = results
          .where((t) =>
              t.title.toLowerCase().contains(query) ||
              t.amount.toLowerCase().contains(query))
          .toList();
    }

    // Filter by transaction type
    if (_selectedTransaksi == 'Pemasukan') {
      results = results
          .where((t) => t.type == _TransactionType.pemasukan)
          .toList();
    } else if (_selectedTransaksi == 'Pengeluaran') {
      results = results
          .where((t) => t.type == _TransactionType.pengeluaran)
          .toList();
    }

    return results;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
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
          'Riwayat Transaksi',
          style: TextStyle(
            color: textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider below appbar
          const Divider(height: 1, color: borderGrey),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderGrey),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                  color: textDark,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Cari',
                  hintStyle: TextStyle(
                    color: textGrey.withAlpha(150),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: textGrey.withAlpha(150),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),

          // Filter chips row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Transaksi',
                  value: _selectedTransaksi,
                  options: ['Semua', 'Pemasukan', 'Pengeluaran'],
                  onSelected: (val) {
                    setState(() => _selectedTransaksi = val);
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Sumber',
                  value: _selectedSumber,
                  options: ['Semua', 'Tunai', 'Bank Mandiri'],
                  onSelected: (val) {
                    setState(() => _selectedSumber = val);
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Tanggal',
                  value: _selectedTanggal,
                  options: ['Semua', 'Hari ini', 'Minggu ini', 'Bulan ini'],
                  onSelected: (val) {
                    setState(() => _selectedTanggal = val);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Transaction list
          Expanded(
            child: _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    const textGrey = Color(0xFF7A7A7A);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        // Section header
        const Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Text(
            'Hari ini',
            style: TextStyle(
              color: textGrey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Transaction items
        ..._filteredTransactions.map(
          (transaction) => _buildTransactionTile(transaction),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(_TransactionItem transaction) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);

    final bool isPengeluaran = transaction.type == _TransactionType.pengeluaran;
    final Color amountColor =
        isPengeluaran ? const Color(0xFFDC2626) : const Color(0xFF0F9F90);
    final Color badgeColor =
        isPengeluaran ? const Color(0xFFDC2626) : const Color(0xFF0F9F90);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderGrey, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          // Icon with badge
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              children: [
                // Document icon container
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: Color(0xFF475569),
                      size: 22,
                    ),
                  ),
                ),
                // Small colored badge indicator
                Positioned(
                  left: 30,
                  top: 30,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        isPengeluaran
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Title and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            transaction.amount,
            style: TextStyle(
              color: amountColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const borderGrey = Color(0xFFE2E8F0);

    final bool isActive = value != 'Semua';

    return GestureDetector(
      onTap: () {
        _showFilterBottomSheet(
          label: label,
          currentValue: value,
          options: options,
          onSelected: onSelected,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF0FDFA) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF0F9F90) : borderGrey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isActive ? value : label,
              style: TextStyle(
                color: isActive ? const Color(0xFF0F9F90) : textDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isActive ? const Color(0xFF0F9F90) : textDark,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet({
    required String label,
    required String currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
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
              // Handle bar
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
              // Title
              Text(
                'Filter $label',
                style: const TextStyle(
                  color: textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              // Options
              ...options.map((option) {
                final isSelected = option == currentValue;
                return InkWell(
                  onTap: () {
                    onSelected(option);
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
                          option,
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
              }),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
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
            SizedBox(
              width: 180,
              height: 180,
              child: CustomPaint(
                painter: _EmptyRiwayatPainter(),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Belum ada riwayat',
              style: TextStyle(
                color: textDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Transaksi yang telah dicatat\nakan muncul di sini.',
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
}

// Data model
enum _TransactionType { pemasukan, pengeluaran }

class _TransactionItem {
  final String title;
  final String date;
  final String amount;
  final _TransactionType type;

  _TransactionItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
  });
}

// Custom painter for empty riwayat state
class _EmptyRiwayatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);

    // Background soft circle
    final bgPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, w * 0.42, bgPaint);

    // Outer ring
    final ringPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, w * 0.42, ringPaint);

    // Document/clipboard body
    final docPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..style = PaintingStyle.fill;

    final docPath = Path();
    docPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.30, h * 0.22, w * 0.70, h * 0.72),
      const Radius.circular(8),
    ));
    canvas.drawPath(docPath, docPaint);

    // Inner white area on document
    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final innerPath = Path();
    innerPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.34, h * 0.30, w * 0.66, h * 0.68),
      const Radius.circular(4),
    ));
    canvas.drawPath(innerPath, innerPaint);

    // Document lines
    final linePaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(w * 0.38, h * 0.38), Offset(w * 0.62, h * 0.38), linePaint);
    canvas.drawLine(
        Offset(w * 0.38, h * 0.45), Offset(w * 0.56, h * 0.45), linePaint);
    canvas.drawLine(
        Offset(w * 0.38, h * 0.52), Offset(w * 0.60, h * 0.52), linePaint);

    // Clock icon overlay
    final clockBgPaint = Paint()
      ..color = const Color(0xFF475569)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.64, h * 0.65), 14, clockBgPaint);

    final clockFace = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(w * 0.64, h * 0.65), 8, clockFace);

    // Clock hands
    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(w * 0.64, h * 0.65), Offset(w * 0.64, h * 0.61), handPaint);
    canvas.drawLine(
        Offset(w * 0.64, h * 0.65), Offset(w * 0.68, h * 0.66), handPaint);

    // Decorative dots
    final dotPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.20, h * 0.35), 4, dotPaint);
    canvas.drawCircle(Offset(w * 0.80, h * 0.45), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.22, h * 0.60), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.30), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
