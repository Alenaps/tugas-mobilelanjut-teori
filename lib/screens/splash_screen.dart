import 'package:flutter/material.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// State untuk ngatur tampilan & waktu transisi splash screen
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Begitu halaman pertama kali muncul, tunggu 2 detik
    // lalu otomatis pindah ke halaman login
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // cek biar gak error kalau halaman udah ditutup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), // navigasi ke LoginScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // warna latar utama biru 

      // Isi halaman ditaruh di tengah layar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // biar konten di tengah vertikal
          children: const [
            // Ikon utama aplikasi 
            Icon(Icons.self_improvement, size: 96, color: Colors.white),

            SizedBox(height: 20),

            // Nama aplikasi "Sobat Sadar"
            Text(
              "Sobat Sadar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
