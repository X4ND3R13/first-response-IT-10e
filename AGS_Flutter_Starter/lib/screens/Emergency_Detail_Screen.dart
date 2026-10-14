import 'package:flutter/material.dart';

class EmergencyDetailScreen extends StatelessWidget {
  final String userName;

  const EmergencyDetailScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // List of emergency options
    final List<Map<String, dynamic>> incidents = [
      {
        'title': 'unconscious',
        'subtitle': 'pasient fainted or not responding',
        'icon': Icons.airline_seat_flat,
        'color': Colors.redAccent,
      },
      {
        'title': 'choking',
        'subtitle': 'patient is having breathing troubles ',
        'icon': Icons.warning_amber_rounded,
        'color': Colors.orangeAccent,
      },
      {
        'title': 'bleeding',
        'subtitle': 'open wound with blood that is constantly spilling out',
        'icon': Icons.bloodtype,
        'color': Colors.red,
      },
      {
        'title': 'other',
        'subtitle': 'patient has another emergency',
        'icon': Icons.more_horiz,
        'color': Colors.grey,
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 35, 40),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: incidents.length,
                  itemBuilder: (context, index) {
                    final item = incidents[index];
                    return Card(
                      color: const Color.fromARGB(255, 18, 84, 79),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                          ),
                        ),
                        title: Text(
                          item['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          item['subtitle'] as String,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.white),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              
              // Back to Login Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 220, 27, 27),
                    side: const BorderSide(color: Color.fromARGB(255, 139, 187, 146)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}