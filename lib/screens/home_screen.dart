import 'package:flutter/material.dart';

// ============================================================================
// FIRST RESPONSE - HOME SCREEN (modern version)
// Look for [CHANGE HERE] comments to edit text, colors, or cases.
// ============================================================================

// Colors used on this screen
const Color kTeal = Color(0xFF0E7C86);
const Color kDarkTeal = Color(0xFF0A5A61);
const Color kEmergencyRed = Color(0xFFE53935);
const Color kBackground = Color(0xFFF4F8F9);
const Color kTextDark = Color(0xFF1E293B);
const Color kTextGrey = Color(0xFF64748B);

// One emergency case (title, short description, icon, color)
class EmergencyCase {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const EmergencyCase({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

// [CHANGE HERE]: add, remove, or rename emergency cases in this list
const List<EmergencyCase> emergencyCases = [
  EmergencyCase(
    title: 'CPR',
    subtitle: 'Person not breathing',
    icon: Icons.favorite,
    color: Color(0xFFE53935),
  ),
  EmergencyCase(
    title: 'Choking',
    subtitle: 'Cannot breathe or talk',
    icon: Icons.air,
    color: Color(0xFF1E88E5),
  ),
  EmergencyCase(
    title: 'Burns',
    subtitle: 'Fire, heat, or hot liquid',
    icon: Icons.local_fire_department,
    color: Color(0xFFF57C00),
  ),
  EmergencyCase(
    title: 'Bleeding',
    subtitle: 'Cuts and heavy bleeding',
    icon: Icons.water_drop,
    color: Color(0xFFC62828),
  ),
  EmergencyCase(
    title: 'Fracture',
    subtitle: 'Broken or injured bone',
    icon: Icons.healing,
    color: Color(0xFF6D4C41),
  ),
  EmergencyCase(
    title: 'Seizure',
    subtitle: 'Shaking or unconscious',
    icon: Icons.flash_on,
    color: Color(0xFF8E24AA),
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Shows the "call emergency services" pop-up
  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.phone_in_talk, color: kEmergencyRed, size: 36),
        title: const Text('Call emergency services?'),
        content: const Text(
          'Indonesia emergency numbers:\n\n'
          '112 - General emergency\n'
          '119 - Ambulance',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: kEmergencyRed),
            onPressed: () {
              Navigator.pop(context);
              // TODO: connect real phone call here (url_launcher package)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calling 112... (demo)')),
              );
            },
            icon: const Icon(Icons.call),
            label: const Text('Call 112'),
          ),
        ],
      ),
    );
  }

  // Runs when a case card is tapped
  void _openCase(EmergencyCase item) {
    // TODO: open the tutorial screen for this case
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.title} tutorial coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        title: const Text(
          'First Response', // [CHANGE HERE]: app title
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: search emergency cases
            },
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text(
                'Stay calm.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Help is one tap away.',
                style: TextStyle(fontSize: 15, color: kTextGrey),
              ),
              const SizedBox(height: 16),

              // BIG EMERGENCY BUTTON
              Material(
                color: kEmergencyRed,
                borderRadius: BorderRadius.circular(20),
                elevation: 4,
                shadowColor: const Color(0x66E53935),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: _showEmergencyDialog,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.call, color: kEmergencyRed, size: 30),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EMERGENCY CALL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tap to call 112 / 119',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Section title
              const Text(
                'What is happening?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              const SizedBox(height: 12),

              // GRID OF EMERGENCY CASES
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: emergencyCases.map((item) {
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    elevation: 1,
                    shadowColor: const Color(0x33000000),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _openCase(item),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(item.icon, color: Colors.white, size: 24),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12, color: kTextGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // QUICK TIP CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kDarkTeal, kTeal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUICK TIP', // [CHANGE HERE]
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD166),
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check the scene is safe before helping.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Then call for help and follow the steps in the tutorial.',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          // TODO: switch to the other screens here
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0x330E7C86),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: kTeal),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services, color: kTeal),
            label: 'Cases',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book, color: kTeal),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: kTeal),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
