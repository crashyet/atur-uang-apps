import 'package:flutter/material.dart';

class JenisDanaScreen extends StatefulWidget {
  const JenisDanaScreen({super.key});

  @override
  State<JenisDanaScreen> createState() => _JenisDanaScreenState();
}

class AccountItem {
  final String title;
  final String balance;
  final String income;
  final String expense;
  bool isVisible;

  AccountItem({
    required this.title,
    required this.balance,
    required this.income,
    required this.expense,
    this.isVisible = true,
  });
}

class _JenisDanaScreenState extends State<JenisDanaScreen> {
  // Account List State (Initial accounts)
  final List<AccountItem> _accounts = [
    AccountItem(
      title: 'Tunai',
      balance: 'Rp10.654.258',
      income: 'Rp10.654.258',
      expense: 'Rp10.654.258',
    ),
    AccountItem(
      title: 'BNI',
      balance: 'Rp10.654.258',
      income: 'Rp10.654.258',
      expense: 'Rp10.654.258',
    ),
    AccountItem(
      title: 'BRI',
      balance: 'Rp10.654.258',
      income: 'Rp10.654.258',
      expense: 'Rp10.654.258',
    ),
  ];

  final _dialogFormKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _initialBalanceController = TextEditingController();

  @override
  void dispose() {
    _bankNameController.dispose();
    _initialBalanceController.dispose();
    super.dispose();
  }

  void _showAddBankDialog() {
    _bankNameController.clear();
    _initialBalanceController.clear();

    const primaryColor = Color(0xFFFF8E42);
    const textDark = Color(0xFF1E1E1E);
    const borderGrey = Color(0xFFE2E8F0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Tambah Bank Baru',
            style: TextStyle(
              color: textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _dialogFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama Bank / Kas',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _bankNameController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Bank Mandiri',
                    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Masukkan nama bank/kas';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Saldo Awal',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _initialBalanceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 5000000',
                    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    prefixText: 'Rp ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan saldo awal';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_dialogFormKey.currentState!.validate()) {
                  // Format currency beautifully
                  final double val = double.tryParse(_initialBalanceController.text) ?? 0.0;
                  final formattedBalance = 'Rp${_formatCurrency(val)}';

                  setState(() {
                    _accounts.add(
                      AccountItem(
                        title: _bankNameController.text.trim(),
                        balance: formattedBalance,
                        income: formattedBalance,
                        expense: 'Rp0',
                      ),
                    );
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Akun ${_bankNameController.text} berhasil ditambahkan!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  String _formatCurrency(double amount) {
    // Basic Indonesian-style separation helper
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

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E1E1E);
    const primaryColor = Color(0xFFFF8E42);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Seluruh Akun
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
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
                    'Seluruh Akun',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer to balance back button
                ],
              ),
            ),

            // 2. Scrollable Account List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: _accounts.length,
                itemBuilder: (context, index) {
                  final account = _accounts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildAccountCard(
                      account: account,
                      onToggleVisibility: () {
                        setState(() {
                          account.isVisible = !account.isVisible;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // 3. Add Bank Button Section at Bottom
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showAddBankDialog,
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tambah Bank',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required AccountItem account,
    required VoidCallback onToggleVisibility,
  }) {
    const textDark = Color(0xFF1E1E1E);
    const textGrey = Color(0xFF7A7A7A);
    const borderGrey = Color(0xFFE2E8F0);
    const tealBorder = Color(0xFF14B8A6);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tealBorder.withAlpha(80), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.title,
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  account.isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: textGrey,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            account.isVisible ? account.balance : 'Rp ••••••••',
            style: const TextStyle(
              color: textDark,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: borderGrey, height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              // Upward Pemasukan
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color(0xFF15803D),
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.isVisible ? account.income : 'Rp ••••',
                            style: const TextStyle(
                              color: textDark,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Pemasukan',
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Downward Pengeluaran
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEE2E2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: Color(0xFFB91C1C),
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.isVisible ? account.expense : 'Rp ••••',
                            style: const TextStyle(
                              color: textDark,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Pengeluaran',
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 9,
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
}
