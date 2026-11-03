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
      'description':
          'Understand health conditions, warning signs, and first aid.',
      'details': 'Heart attack • Diabetes • Stroke • CPR • Burns',
      'icon': Icons.menu_book_rounded,
      'tag': 'LEARN',
    },
    {
      'title': 'Emergency Awareness',
      'description':
          'Learn why quick action and contacting emergency services matter.',
      'details': 'Recognize danger • Stay safe • Get help',
      'icon': Icons.emergency_rounded,
      'tag': 'BE PREPARED',
    },
    {
      'title': 'First Aid Basics',
      'description':
          'Explore basic response principles and when to seek professional help.',
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
      final searchable =
          '${feature['title']} ${feature['description']} ${feature['details']}'
              .toLowerCase();
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
            icon:
                Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
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
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF29242A)),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('EXPLORE',
                    style: TextStyle(
                        color: darkRed,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Choose a section to build your medical knowledge and learn how to respond more safely.',
            style:
                TextStyle(color: Color(0xFF746B70), height: 1.45, fontSize: 13),
          ),
          const SizedBox(height: 15),
          if (visibleFeatures.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26),
              child:
                  Center(child: Text('No sections found. Try another search.')),
            )
          else
            ...visibleFeatures.map(_buildFeatureCard),
          const SizedBox(height: 8),
          _buildQuickGuide(),
          const SizedBox(height: 18),
          const Text(
            'Important: This app is for education only. It does not replace professional medical advice, certified first-aid training, or emergency services.',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color(0xFF8C7777), fontSize: 11, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    final cleanName =
        widget.userName.trim().isEmpty ? 'there' : widget.userName.trim();
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
        boxShadow: [
          BoxShadow(
              color: red.withValues(alpha: 0.22),
              blurRadius: 18,
              offset: const Offset(0, 8))
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 2,
            child: Icon(Icons.health_and_safety_rounded,
                size: 104, color: Colors.white.withValues(alpha: 0.12)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('YOUR FIRST-RESPONSE GUIDE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
              ),
              const SizedBox(height: 17),
              Text(
                'Logged In: $cleanName',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Learn today.\nBe ready to help.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    height: 1.12,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore simple medical explainers and first-aid awareness topics so you can recognize risks and know when to get help.',
                style: TextStyle(
                    color: Color(0xFFFFEDED), fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _openLearning,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start learning'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: darkRed,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
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
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF5B2020).withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
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
                decoration: BoxDecoration(
                    color: const Color(0xFFFFE7E7),
                    borderRadius: BorderRadius.circular(16)),
                child: Icon(feature['icon'] as IconData, color: red, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feature['tag'] as String,
                        style: const TextStyle(
                            color: red,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(feature['title'] as String,
                        style: const TextStyle(
                            color: Color(0xFF29242A),
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 5),
                    Text(feature['description'] as String,
                        style: const TextStyle(
                            color: Color(0xFF71676D),
                            fontSize: 12,
                            height: 1.45)),
                    const SizedBox(height: 8),
                    Text(feature['details'] as String,
                        style: const TextStyle(
                            color: Color(0xFF8E1717),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            height: 1.4)),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFB8A0A0), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickGuide() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          color: const Color(0xFFFFEAEA),
          borderRadius: BorderRadius.circular(20)),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: darkRed, size: 25),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How to use this app',
                    style: TextStyle(
                        color: darkRed,
                        fontWeight: FontWeight.w900,
                        fontSize: 14)),
                SizedBox(height: 6),
                Text(
                    '1. Pick a topic.\n2. Read the signs and key facts.\n3. In a real emergency, keep yourself safe and contact local emergency services.',
                    style: TextStyle(
                        color: Color(0xFF6D4B4B), fontSize: 12, height: 1.55)),
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
  static const red = Color(0xFFC62828);
  static const darkRed = Color(0xFF8E1717);
  static const background = Color(0xFFFFFAFA);

  String userName = '';
  String studentClass = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      userName = prefs.getString('user_name') ?? 'Unknown';
      studentClass = prefs.getString('student_class') ?? 'Unknown';
      isLoading = false;
    });
  }

  String get initials {
    if (userName.trim().isEmpty || userName == 'Unknown') {
      return '?';
    }

    final parts = userName.trim().split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: const Color(0xFF29242A),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: red,
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              children: [
                // PROFILE HEADER
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        darkRed,
                        red,
                        Color(0xFFE45151),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: red.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // AVATAR
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.8),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          child: Text(
                            initials,
                            style: const TextStyle(
                              color: red,
                              fontSize: 29,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 17),

                      // NAME
                      Text(
                        userName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 7),

                      // STUDENT BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.17),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'STUDENT ACCOUNT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 17),

                      Container(
                        height: 1,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),

                      const SizedBox(height: 14),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Welcome to First Response',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // SECTION TITLE
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Color(0xFF29242A),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Your personal account details.',
                  style: TextStyle(
                    color: Color(0xFF95888C),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 17),

                // NAME CARD
                _buildInfoCard(
                  icon: Icons.person_outline_rounded,
                  title: 'Full Name',
                  value: userName,
                ),

                const SizedBox(height: 12),

                // CLASS CARD
                _buildInfoCard(
                  icon: Icons.school_outlined,
                  title: 'Class / Grade',
                  value: studentClass,
                ),

                const SizedBox(height: 25),

                // ACCOUNT SECTION
                const Text(
                  'Account Overview',
                  style: TextStyle(
                    color: Color(0xFF29242A),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFF2E5E5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.shield_rounded,
                          color: Color(0xFF2E9B59),
                          size: 23,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Status',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF29242A),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your profile information',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF95888C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'ACTIVE',
                          style: TextStyle(
                            color: Color(0xFF2E9B59),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // FOOTER
                Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.health_and_safety_rounded,
                        color: red,
                        size: 27,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'FIRST RESPONSE',
                        style: TextStyle(
                          color: darkRed,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Learn today. Be ready to help.',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // REUSABLE INFORMATION CARD
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFF2E5E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: red,
              size: 23,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF95888C),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF29242A),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF43A66B),
            size: 19,
          ),
        ],
      ),
    );
  }
}
