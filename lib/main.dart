import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_phone_screen.dart';
import 'screens/auth/register_otp_screen.dart';
import 'screens/auth/register_details_screen.dart';
import 'screens/auth/forgot_password_phone_screen.dart';
import 'screens/auth/forgot_password_otp_screen.dart';
import 'screens/auth/forgot_password_new_screen.dart';
import 'screens/homescreen/homescreen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/jenisdana/jenis_dana.dart';
import 'screens/transaksi/pengeluaran.dart';
import 'screens/transaksi/pemasukan.dart';
import 'screens/transaksi/informasi.dart';
import 'screens/notifikasi/semua_pesan.dart';
import 'screens/riwayat/riwayat_transaksi.dart';
import 'screens/analisa/analisa_screen.dart';
import 'screens/laporan/laporan_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atur Uang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8E42),
          primary: const Color(0xFFFF8E42),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register_phone': (context) => const RegisterPhoneScreen(),
        '/register_otp': (context) => const RegisterOtpScreen(),
        '/register_details': (context) => const RegisterDetailsScreen(),
        '/forgot_password_phone': (context) => const ForgotPasswordPhoneScreen(),
        '/forgot_password_otp': (context) => const ForgotPasswordOtpScreen(),
        '/forgot_password_new': (context) => const ForgotPasswordNewScreen(),
        '/homescreen': (context) => const Homescreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/jenis_dana': (context) => const JenisDanaScreen(),
        '/catat_pengeluaran': (context) => const PengeluaranScreen(),
        '/catat_pemasukan': (context) => const PemasukanScreen(),
        '/transaksi_informasi': (context) => const InformasiScreen(),
        '/notifikasi': (context) => const SemuaPesanScreen(),
        '/riwayat': (context) => const RiwayatTransaksiScreen(),
        '/analisa': (context) => const AnalisaScreen(),
        '/laporan': (context) => const LaporanScreen(),
      },
    );
  }
}
