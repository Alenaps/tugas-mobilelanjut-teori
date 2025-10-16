import 'package:flutter/material.dart';

class KomunitasScreen extends StatelessWidget {
  const KomunitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List data komunitas yang akan ditampilkan di halaman
    // Setiap item berisi nama, deskripsi, jumlah anggota, dan gambar dari asset
    final List<Map<String, String>> komunitas = [
      {
        "nama": "Sobat Sadar Lampung",
        "deskripsi": "Grup dukungan untuk mahasiswa yang peduli kesehatan mental.",
        "anggota": "256 anggota",
        "gambar": "assets/komunitas1.jpg"
      },
      {
        "nama": "Komunitas Anti Narkoba",
        "deskripsi": "Berbagi inspirasi hidup sehat dan bebas narkoba.",
        "anggota": "320 anggota",
        "gambar": "assets/komunitas2.jpg"
      },
      {
        "nama": "Teman Cerita Kampus",
        "deskripsi": "Tempat aman untuk bercerita dan saling support 🤍",
        "anggota": "198 anggota",
        "gambar": "assets/komunitas3.jpg"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ListView.builder dipakai untuk menampilkan daftar komunitas secara dinamis
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: komunitas.length, // jumlah item sesuai data di atas
        itemBuilder: (context, index) {
          final data = komunitas[index]; // ambil data komunitas per index

          return Card(
            elevation: 3, // efek bayangan kartu biar kelihatan naik
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 8),

            // ListTile adalah widget siap pakai untuk tampilan seperti chat WA atau grup
            child: ListTile(
              // Foto komunitas di sebelah kiri
              leading: CircleAvatar(
                backgroundImage: AssetImage(data["gambar"]!), // ambil gambar dari asset
                radius: 26,
              ),

              // Nama komunitas di bagian atas
              title: Text(
                data["nama"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              // Deskripsi dan jumlah anggota di bawahnya
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["deskripsi"]!,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data["anggota"]!,
                    style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
                  ),
                ],
              ),

              // Tombol panah ke kanan (kayak di daftar grup WA)
              trailing: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.blueAccent,
                  size: 18,
                ),
                onPressed: () {
                  // Saat tombol diklik, muncul notifikasi sementara (SnackBar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Masuk ke grup ${data["nama"]!}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
