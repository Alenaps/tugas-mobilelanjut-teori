import 'package:flutter/material.dart';
import '../widgets/chat_list.dart';
import 'profile_screen.dart';
import 'komunitas_screen.dart';
import 'panggilan_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String name;
  final String npm;

  const DashboardScreen({super.key, required this.name, required this.npm});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // buat ngatur halaman mana yang lagi aktif
  late final List<Widget> _pages; // list halaman (chat, komunitas, panggilan)
  late AnimationController _controller; // buat animasi transisi
  late Animation<double> _fadeAnimation; // animasi efek fade (muncul halus)
  late Animation<Offset> _slideAnimation; // animasi efek geser

  final PageController _pageController = PageController(); // kontrol halaman

  @override
  void initState() {
    super.initState();

    // setup animasi
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // efek fade in/out
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // efek geser masuk dari kanan
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(_controller);

    // daftar halaman utama
    _pages = [
      const ChatList(),       // halaman chat konselor
      const KomunitasScreen(), // halaman komunitas
      const PanggilanScreen(), // halaman panggilan bantuan
    ];

    _controller.forward(); // mulai animasi
  }

  @override
  void dispose() {
    // bersihin controller biar gak bocor memori
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Ganti judul AppBar sesuai halaman yang aktif
  String get _pageTitle {
    switch (_selectedIndex) {
      case 0:
        return "Chat Konselor";
      case 1:
        return "Komunitas Sobat Sadar";
      case 2:
        return "Panggilan Bantuan";
      default:
        return "Sobat Sadar";
    }
  }

  // Ganti ikon FAB (Floating Action Button) tiap halaman
  IconData get _fabIcon {
    switch (_selectedIndex) {
      case 0:
        return Icons.message_rounded; // buat chat
      case 1:
        return Icons.group_add_rounded; // buat komunitas
      case 2:
        return Icons.call_rounded; // buat panggilan
      default:
        return Icons.add;
    }
  }

  // Aksi ketika FAB ditekan (beda tiap halaman)
  void _onFabPressed() {
    switch (_selectedIndex) {
      case 0:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur chat baru segera hadir!')),
        );
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bergabung dengan komunitas baru')),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur panggilan masih dikembangkan')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // warna background lembut

      // AppBar dengan desain melengkung & judul dinamis
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Row(
          children: [
            const Icon(Icons.self_improvement, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              _pageTitle, // judul berubah sesuai tab
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {}, // tombol cari (belum aktif)
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            tooltip: 'Profil Anda',
            onPressed: () {
              // pindah ke halaman profil
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(name: widget.name, npm: widget.npm),
                ),
              );
            },
          ),
        ],
      ),

      // Transisi halaman dengan animasi fade + slide
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
                _controller.forward(from: 0); // refresh animasi pas ganti halaman
              });
            },
            children: _pages, // isi semua halaman
          ),
        ),
      ),

      // Navigasi bawah (Bottom Navigation Bar)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // tab yang aktif
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (index) {
            // ganti halaman pas tab diklik
            setState(() => _selectedIndex = index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: "Komunitas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              activeIcon: Icon(Icons.call),
              label: "Panggilan",
            ),
          ],
        ),
      ),

      // Tombol aksi mengambang (FAB) — berubah sesuai halaman
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        onPressed: _onFabPressed,
        child: Icon(_fabIcon, color: Colors.white, size: 26),
      ),
    );
  }
}
