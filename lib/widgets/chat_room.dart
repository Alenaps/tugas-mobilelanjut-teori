import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  final String nama; // Nama konselor yang dipilih dari daftar chat
  final String avatar; // Foto profil konselor dari assets

  const ChatRoomScreen({
    super.key,
    required this.nama,
    required this.avatar,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  // Controller buat ngatur input teks (pesan yang diketik user)
  final TextEditingController _controller = TextEditingController();

  // List buat nyimpen semua pesan yang dikirim/diterima (sementara belum ke DB)
  final List<Map<String, String>> _messages = [];

  // Fungsi buat ngirim pesan (pas tombol kirim ditekan)
  void _sendMessage() {
    // Cek dulu biar gak kirim pesan kosong
    if (_controller.text.trim().isEmpty) return;

    // Tambahin pesan ke daftar pesan, lalu kosongin kolom input
    setState(() {
      _messages.add({
        "sender": "Anda", // penanda siapa pengirimnya
        "text": _controller.text, // isi pesan
      });
      _controller.clear(); // hapus teks dari input setelah dikirim
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            // Tampilkan foto profil konselor
            CircleAvatar(backgroundImage: AssetImage(widget.avatar)),
            const SizedBox(width: 10),
            // Nama konselor
            Text(widget.nama),
          ],
        ),
      ),

      // Bagian isi utama halaman
      body: Column(
        children: [
          // ListView buat nampilin semua pesan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length, // jumlah pesan
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["sender"] == "Anda"; // cek apakah pesan dari user

                return Align(
                  // Atur posisi pesan (kanan: user, kiri: konselor)
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      // Warna beda tergantung siapa yang ngirim
                      color: isUser
                          ? Colors.blueAccent
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(
                        // Warna teks menyesuaikan warna background bubble
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bagian input pesan di bawah layar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                // Kolom buat ngetik pesan
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...", // placeholder text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),

                // Tombol kirim (ikon pesawat kertas)
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage, // panggil fungsi kirim pesan
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
