import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ags_flutter_starter/screens/learn_screen.dart';

class MenuScreen extends StatefulWidget {
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const red = Color(0xFFC62828);
  static const darkRed = Color(0xFF8E1717);
  static const background = Color(0xFFFFF7F7);

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _features = const [
    {
      'title': 'Medical Learning Hub',
      'description': 'Understand health conditions, warning signs, and first aid.',
      'details': 'Heart attack • Diabetes • Stroke • CPR • Burns',
      'icon': Icons.menu_book_rounded,
      'tag': 'LEARN',
    },
    {
      'title': 'Emergency Awareness',
      'description': 'Learn why quick action and contacting emergency services matter.',
      'details': 'Recognize danger • Stay safe • Get help',
      'icon': Icons.emergency_rounded,
      'tag': 'BE PREPARED',
    },
    {
      'title': 'First Aid Basics',
      'description': 'Explore basic response principles and when to seek professional help.',
      'details': 'CPR basics • Burn care • Emergency priorities',
      'icon': Icons.health_and_safety_rounded,
      'tag': 'ESSENTIALS',
    },
  ];

  void _openLearning() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LearnScreen()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final visibleFeatures = _features.where((feature) {
      final searchable = '${feature['title']} ${feature['description']} ${feature['details']}'.toLowerCase();
      return searchable.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkRed,
        foregroundColor: Colors.white,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search learning topics...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (_) => setState(() {}),
              )
            : const Text(
                'First Response',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Close search' : 'Search',
            icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                if (_isSearching) _searchController.clear();
                _isSearching = !_isSearching;
              });
            },
          ),
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
        children: [
          _buildHero(),
          const SizedBox(height: 22),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'What can you do here?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF29242A)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFFFE5E5), borderRadius: BorderRadius.circular(20)),
                child: const Text('EXPLORE', style: TextStyle(color: darkRed, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Choose a section to build your medical knowledge and learn how to respond more safely.',
            style: TextStyle(color: Color(0xFF746B70), height: 1.45, fontSize: 13),
          ),
          const SizedBox(height: 15),
          if (visibleFeatures.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26),
              child: Center(child: Text('No sections found. Try another search.')),
            )
          else
            ...visibleFeatures.map(_buildFeatureCard),
          const SizedBox(height: 8),
          _buildQuickGuide(),
          const SizedBox(height: 18),
          const Text(
            'Important: This app is for education only. It does not replace professional medical advice, certified first-aid training, or emergency services.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF8C7777), fontSize: 11, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    final cleanName = widget.userName.trim().isEmpty ? 'there' : widget.userName.trim();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkRed, red, Color(0xFFE14A4A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: red.withValues(alpha: 0.22), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 2,
            child: Icon(Icons.health_and_safety_rounded, size: 104, color: Colors.white.withValues(alpha: 0.12)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(20)),
                child: const Text('YOUR FIRST-RESPONSE GUIDE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              ),
              const SizedBox(height: 17),
              Text('Hi, $cleanName!', style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              const Text(
                'Learn today.\nBe ready to help.',
                style: TextStyle(color: Colors.white, fontSize: 29, height: 1.12, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore simple medical explainers and first-aid awareness topics so you can recognize risks and know when to get help.',
                style: TextStyle(color: Color(0xFFFFEDED), fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _openLearning,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start learning'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: darkRed,
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    final isLearn = feature['title'] == 'Medical Learning Hub';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF2DEDE)),
        boxShadow: [BoxShadow(color: const Color(0xFF5B2020).withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: _openLearning,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(color: const Color(0xFFFFE7E7), borderRadius: BorderRadius.circular(16)),
                child: Icon(feature['icon'] as IconData, color: red, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feature['tag'] as String, style: const TextStyle(color: red, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(feature['title'] as String, style: const TextStyle(color: Color(0xFF29242A), fontSize: 16, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 5),
                    Text(feature['description'] as String, style: const TextStyle(color: Color(0xFF71676D), fontSize: 12, height: 1.45)),
                    const SizedBox(height: 8),
                    Text(feature['details'] as String, style: const TextStyle(color: Color(0xFF8E1717), fontSize: 10, fontWeight: FontWeight.w700, height: 1.4)),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFB8A0A0), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickGuide() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(color: const Color(0xFFFFEAEA), borderRadius: BorderRadius.circular(20)),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: darkRed, size: 25),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How to use this app', style: TextStyle(color: darkRed, fontWeight: FontWeight.w900, fontSize: 14)),
                SizedBox(height: 6),
                Text('1. Pick a topic.\n2. Read the signs and key facts.\n3. In a real emergency, keep yourself safe and contact local emergency services.', style: TextStyle(color: Color(0xFF6D4B4B), fontSize: 12, height: 1.55)),
              ],
            ),
          ),
        ],
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
                                showPassword ? password : '•' * password.length,
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
