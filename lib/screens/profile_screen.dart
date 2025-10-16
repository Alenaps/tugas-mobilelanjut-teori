import 'package:flutter/material.dart';

// Menampilkan info mahasiswa yang udah login
class ProfileScreen extends StatelessWidget {
  final String name; // variabel buat nampung nama mahasiswa dari halaman login
  final String npm;  // variabel buat nampung NPM mahasiswa

  const ProfileScreen({super.key, required this.name, required this.npm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      // Bagian AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Profil Mahasiswa', // judul di atas
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // biar teksnya di tengah
      ),

      // Bagian Isi Halaman
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Foto Profil Mahasiswa
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // bentuk bulat
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                  // ambil foto dari folder assets
                  image: const DecorationImage(
                    image: AssetImage('assets/profile.jpeg'),
                    fit: BoxFit.cover, // biar gambar pas di lingkaran
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Nama dan NPM yang dikirim dari halaman login
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              'NPM: ',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            Text(
              npm,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            // Info tambahan seperti Prodi, Email, dan Nomor HP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      // panggil widget kecil di bawah (_InfoRow)
                      _InfoRow(
                        icon: Icons.school_outlined,
                        label: "Program Studi",
                        value: "Manajemen Informatika",
                      ),
                      Divider(),
                      _InfoRow(
                        icon: Icons.email_outlined,
                        label: "Email",
                        value: "putrialena180@gmail.com",
                      ),
                      Divider(),
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: "Nomor HP",
                        value: "+62 812-3456-7890",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Tombol untuk kembali ke halaman sebelumnya
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context), // fungsi balik halaman
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text(
                'Kembali',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Widget kecil buat nampilin baris info profil (biar gak nulis ulang terus)
class _InfoRow extends StatelessWidget {
  final IconData icon; // ikon di samping kiri
  final String label; // label info (contoh: Email)
  final String value; // isi dari info (contoh: putrialena@gmail.com)

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
