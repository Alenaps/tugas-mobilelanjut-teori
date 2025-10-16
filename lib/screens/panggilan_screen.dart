import 'package:flutter/material.dart';

class PanggilanScreen extends StatelessWidget {
  const PanggilanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy panggilan (belum pakai database)
    // Tiap item punya nama konselor, waktu panggilan, jenis (suara/video), dan gambar profil
    final List<Map<String, dynamic>> calls = [
      {
        "nama": "Konselor 1",
        "waktu": "Hari ini, 10.30",
        "jenis": "Panggilan Suara",
        "ikon": Icons.call,
        "gambar": "assets/konselor1.jpg"
      },
      {
        "nama": "Konselor 2",
        "waktu": "Kemarin, 18.45",
        "jenis": "Panggilan Video",
        "ikon": Icons.videocam,
        "gambar": "assets/konselor2.jpg"
      },
      {
        "nama": "Konselor 3",
        "waktu": "2 hari lalu, 09.10",
        "jenis": "Panggilan Suara",
        "ikon": Icons.call,
        "gambar": "assets/konselor3.jpg"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100], // warna latar belakang 

      // List panggilan ditampilkan pakai ListView.builder
      body: ListView.builder(
        itemCount: calls.length, // jumlah data
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final panggilan = calls[index]; // ambil data per item

          // Tampilkan setiap panggilan dalam bentuk card
          return Card(
            elevation: 3, // efek bayangan
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              // Foto profil konselor
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(panggilan["gambar"]!),
              ),

              // Nama konselor
              title: Text(
                panggilan["nama"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              // Info jenis + waktu panggilan
              subtitle: Text(
                "${panggilan["jenis"]} • ${panggilan["waktu"]}",
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),

              // Tombol aksi (ikon telepon/video)
              trailing: IconButton(
                icon: Icon(panggilan["ikon"], color: Colors.green),
                onPressed: () {
                  // Kalau ditekan, muncul notifikasi kecil (SnackBar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Memulai ${panggilan["jenis"]}...'),
                    ),
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
