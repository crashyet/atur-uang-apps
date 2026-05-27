import 'package:flutter/material.dart';
import 'informasi.dart'; // To reference TransactionArguments

class PemasukanScreen extends StatefulWidget {
  const PemasukanScreen({super.key});

  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nominalController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String? _selectedAccount;
  String? _selectedSource;

  final List<String> _accounts = ['Tunai', 'Bank Mandiri', 'BNI', 'BRI'];

  @override
  void dispose() {
    _nominalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Format date helper: "Hari ini, 18 Januari 2026"
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
    final prefix = isToday ? 'Hari ini, ' : '';

    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final monthName = months[date.month - 1];

    return '$prefix${date.day} $monthName ${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF8E42), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Color(0xFF1E1E1E), // Body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);
    const tealColor = Color(0xFF0F9F90);
    const redAccent = Color(0xFFEF4444);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back_ios_new, color: textDark, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Catat Transaksi',
                      style: TextStyle(
                        color: textDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40), // Balanced spacer
                  ],
                ),
                const SizedBox(height: 24),

                // 2. Custom Active Tabs (Pengeluaran vs Pemasukan)
                Row(
                  children: [
                    // Inactive Pengeluaran Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Slide transition / Replace named route
                          Navigator.pushReplacementNamed(context, '/catat_pengeluaran');
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
                              Icon(Icons.arrow_downward_rounded, color: textGrey, size: 16),
                              SizedBox(width: 6),
                              Text(
                                'Pengeluaran',
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
                    // Active Pemasukan Tab
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: tealColor, width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.arrow_upward_rounded, color: tealColor, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Pemasukan',
                              style: TextStyle(
                                color: tealColor,
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
                const SizedBox(height: 24),

                // 3. Date Selection Row
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: textGrey, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(_selectedDate),
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: textGrey, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // 4. Nama Akun Dropdown Field
                const Text(
                  'Nama Akun',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedAccount,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: tealColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent, width: 1.5),
                    ),
                  ),
                  hint: const Text(
                    'Pilih Akun Anda',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: textGrey),
                  items: _accounts.map((account) {
                    return DropdownMenuItem(
                      value: account,
                      child: Text(account, style: const TextStyle(fontSize: 14, color: textDark)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAccount = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih Akun Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 5. Nominal Field
                const Text(
                  'Nominal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nominalController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 15, color: textDark, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Rp',
                            style: TextStyle(
                              fontSize: 15,
                              color: textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: borderGrey,
                              thickness: 1.5,
                              width: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: '0',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15, fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: tealColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Masukkan nominal transaksi';
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return 'Nominal harus lebih besar dari 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 6. Sumber Dana Dropdown Field (Penerima Dana / Akun Tujuan)
                const Text(
                  'Sumber Dana',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedSource,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: tealColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: redAccent, width: 1.5),
                    ),
                  ),
                  hint: const Text(
                    'Pilih Sumber Dana yang Tersedia',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: textGrey),
                  items: _accounts.map((account) {
                    return DropdownMenuItem(
                      value: account,
                      child: Text(account, style: const TextStyle(fontSize: 14, color: textDark)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSource = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih Sumber Dana';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 7. Keterangan (Opsional) Field
                const Text(
                  'Keterangan (Opsional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  style: const TextStyle(fontSize: 15, color: textDark),
                  decoration: InputDecoration(
                    hintText: 'Keterangan transaksi',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: tealColor, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                // 8. Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Format currency value nicely
                        final double amountVal = double.tryParse(_nominalController.text) ?? 0.0;
                        final formattedAmount = 'Rp${_formatCurrency(amountVal)}';

                        Navigator.pushNamed(
                          context,
                          '/transaksi_informasi',
                          arguments: TransactionArguments(
                            type: 'pemasukan',
                            accountName: _selectedAccount!,
                            amount: formattedAmount,
                            sourceOfFunds: _selectedSource!,
                            notes: _notesController.text.trim(),
                            date: _formatDateWithoutPrefix(_selectedDate),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      'Catat Pemasukan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    String str = amount.toInt().toString();
    if (str.length <= 3) return str;
    String formatted = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      formatted = str[i] + formatted;
      count++;
      if (count == 3 && i > 0) {
        formatted = '.$formatted';
        count = 0;
      }
    }
    return formatted;
  }

  String _formatDateWithoutPrefix(DateTime date) {
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final monthName = months[date.month - 1];
    return '${date.day} $monthName ${date.year}';
  }
}
