import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller untuk ambil input dari TextField (nama & npm)
    final TextEditingController nameController = TextEditingController();
    final TextEditingController npmController = TextEditingController();

    return Scaffold(
      // Bagian atas (judul aplikasi)
      appBar: AppBar(
        title: const Text('Login Sobat Sadar'),
        centerTitle: true, // biar judulnya di tengah
      ),

      // Body utama (isi halaman)
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // biar semua konten di tengah layar secara vertikal
          children: [
            // Icon kunci sebagai logo login
            const Icon(Icons.lock_open_rounded,
                color: Colors.blueAccent, size: 80),

            const SizedBox(height: 20), // jarak antar elemen

            // Input nama mahasiswa
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Mahasiswa', // label teks di dalam field
                border: OutlineInputBorder(), // garis tepi kotak input
              ),
            ),

            const SizedBox(height: 16),

            // Input NPM mahasiswa
            TextField(
              controller: npmController,
              decoration: const InputDecoration(
                labelText: 'NPM',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 60, vertical: 14), // ukuran tombol
              ),
              onPressed: () {
                // Saat tombol ditekan, pindah ke halaman Dashboard
                // dan kirim data nama + npm ke sana
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                      name: nameController.text, // ambil teks nama
                      npm: npmController.text, // ambil teks npm
                    ),
                  ),
                );
              },
              child: const Text(
                'Masuk',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
