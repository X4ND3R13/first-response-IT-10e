import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_screen.dart';
// ============================================================================
// 🍽️ MENUSCREEN - KANTINKU STARTER TEMPLATE (Week 6: Navigation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// File ini adalah halaman Daftar Menu setelah user berhasil login.
// Sesuaikan nama menu, harga, ikon, dan warna dengan wireframe tim kamu!
// ============================================================================

class MenuScreen extends StatefulWidget {
  final String userName;
  
  const MenuScreen({super.key, required this.userName});
     @override
  State<MenuScreen> createState() => _MenuScreenState();
  }

class _MenuScreenState extends State<MenuScreen> {
    bool _isSearching = false;
   final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // [GANTI DI SINI]: Ganti daftar menu dengan menu kantin tim kamu!
    final List<Map<String, dynamic>> menuItems = [
      {'name': 'lorem ipsum', 'price': 'lorem ipsum', 'icon': Icons.rice_bowl, 'stall': 'lorem ipsum'},
      {'name': 'lorem ipsum', 'price': 'lorem ipsum', 'icon': Icons.ramen_dining, 'stall': 'lorem ipsum'},
      {'name': 'lorem ipsum', 'price': 'lorem ipsum', 'icon': Icons.set_meal, 'stall': 'lorem ipsum'},
      {'name': 'lorem ipsum', 'price': 'lorem ipsum', 'icon': Icons.local_drink, 'stall': 'lorem ipsum'},
      {'name': 'lorem ipsum', 'price': 'lorem ipsum', 'icon': Icons.grass, 'stall': 'lorem ipsum'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF092328),
      appBar: AppBar(
        title: _isSearching
    ? TextField(
        controller: _searchController,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {});
        },
      )
    : const Text(
        'what we offer',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
        backgroundColor: const Color(0xFF12544F),
        foregroundColor: Colors.white,
        actions: [
  // SEARCH 🔍
  IconButton(
    icon: Icon(
      _isSearching ? Icons.close : Icons.search,
    ),
    onPressed: () {
      setState(() {
        if (_isSearching) {
          _searchController.clear();
        }
        _isSearching = !_isSearching;
      });
    },
  ),

  // PROFILE 👤
  IconButton(
    icon: const Icon(Icons.person),
    tooltip: 'Profile',
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    },
  ),
],
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'articles, and possible courses:', // Menerima nama dari LoginScreen
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8BBB92),
                ),
              ),
            ),

            // Daftar Menu
            ...menuItems
    .where((item) {
      final query = _searchController.text.toLowerCase();

      if (query.isEmpty) return true;

      return item['name']
              .toString()
              .toLowerCase()
              .contains(query) ||
          item['stall']
              .toString()
              .toLowerCase()
              .contains(query) ||
          item['price']
              .toString()
              .toLowerCase()
              .contains(query);
    })
    .map((item) => _buildMenuCard(context, item))
    .toList(),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF8BBB92).withValues(alpha: 0.3),
          child: Icon(
            item['icon'] as IconData,
            color: const Color(0xFF12544F),
          ),
        ),
        title: Text(
          item['name'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15,
            color: Color(0xFF092328),
          ),
        ),
        subtitle: Text(
          '${item['stall']}  •  ${item['price']}',
          style: const TextStyle(color: Color(0xFF2A835F), fontSize: 13),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF12544F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          onPressed: () {
            // TODO: Tambahkan ke cart, lalu push ke CartScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  userName: widget.userName,
                  selectedItem: item['name'] as String,
                  selectedPrice: item['price'] as String,
                ),
              ),
            );
          },
          child: const Text('view article/course', style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String password = '';
  String studentClass = '';
  bool isLoading = true;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('user_name') ?? 'Unknown';
      password = prefs.getString('user_password') ?? 'Unknown';
      studentClass = prefs.getString('student_class') ?? 'Unknown';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF092328),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF12544F),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Profile Icon
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF8BBB92),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF12544F),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Name
                  _buildInfoCard(
                    icon: Icons.person_outline,
                    title: 'Name',
                    value: userName,
                  ),

                  const SizedBox(height: 15),

                  // Class
                  _buildInfoCard(
                    icon: Icons.school_outlined,
                    title: 'Class',
                    value: studentClass,
                  ),

                  const SizedBox(height: 15),

                  // Password
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF12544F),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                showPassword
                                    ? password
                                    : '•' * password.length,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF092328),
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF12544F),
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF12544F),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF092328),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}