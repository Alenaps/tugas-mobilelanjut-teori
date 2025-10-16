import 'package:flutter/material.dart';


class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk daftar konselor (nama, status, foto, online/offline)
    final List<Map<String, dynamic>> konselorList = [
      {
        "nama": "dr. Ayu Pratiwi, S.Psi",
        "status": "Aktif sekarang",
        "gambar": "assets/konselor1.jpg",
        "online": true,
      },
      {
        "nama": "dr. Bima Saputra, Psikolog",
        "status": "Terakhir online 2 jam lalu",
        "gambar": "assets/konselor2.jpg",
        "online": false,
      },
      {
        "nama": "dr. Clara Wijaya, S.Psi",
        "status": "Aktif sekarang",
        "gambar": "assets/konselor3.jpg",
        "online": true,
      },
      {
        "nama": "dr. Dimas Arya, Psikolog Klinis",
        "status": "Terakhir online kemarin",
        "gambar": "assets/konselor4.jpg",
        "online": false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // List semua konselor
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: konselorList.length,
        itemBuilder: (context, index) {
          final konselor = konselorList[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

              // Foto profil + indikator online/offline
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(konselor["gambar"]!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: konselor["online"]
                            ? Colors.green
                            : Colors.grey, // warna hijau kalau online
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              // Nama dan status konselor
              title: Text(
                konselor["nama"]!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                konselor["status"]!,
                style: TextStyle(
                  color: konselor["online"]
                      ? Colors.green
                      : Colors.grey[600], // warna teks tergantung status
                  fontSize: 13,
                ),
              ),

              // Icon chat di sebelah kanan
              trailing: const Icon(Icons.chat_bubble_outline,
                  color: Colors.blueAccent),

              // Klik salah satu konselor -> pindah ke halaman chat
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatRoomPage(nama: konselor["nama"]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman chat antara user dan konselor
class ChatRoomPage extends StatelessWidget {
  final String nama;

  const ChatRoomPage({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tampilkan nama konselor di atas
        title: Text(nama, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      backgroundColor: Colors.grey[100],

      // Kolom utama (isi chat + input pesan)
      body: Column(
        children: [
          // Bagian isi percakapan (pesan masuk dan keluar)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                // Pesan dari konselor
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: "Halo, ada yang bisa saya bantu hari ini?",
                    isSender: false,
                  ),
                ),

                // Pesan dari user
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    message:
                        "Halo Dok, saya mau konsultasi tentang stres kuliah.",
                    isSender: true,
                  ),
                ),

                // Balasan konselor
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: "Baik, bisa kamu ceritakan lebih detail ya 😊",
                    isSender: false,
                  ),
                ),
              ],
            ),
          ),

          // Bagian bawah: input pesan + tombol kirim
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // TextField buat ngetik pesan
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Tombol kirim pesan (belum ada fungsi kirim beneran)
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 22,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Komponen gelembung chat (bubble)
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender; // true kalau pesan dari user, false kalau dari konselor

  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),

      // Desain bubble chat (warna, radius, bayangan)
      decoration: BoxDecoration(
        color: isSender ? Colors.blueAccent : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(14),
          topRight: const Radius.circular(14),
          bottomLeft:
              isSender ? const Radius.circular(14) : const Radius.circular(0),
          bottomRight:
              isSender ? const Radius.circular(0) : const Radius.circular(14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: 0.1),
            blurRadius: 3,
          ),
        ],
      ),

      // Teks isi pesan
      child: Text(
        message,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black87,
          fontSize: 15,
        ),
      ),
    );
  }
}
