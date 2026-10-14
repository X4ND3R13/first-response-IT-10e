import 'package:flutter/material.dart';
import 'package:ags_flutter_starter/screens/menu_screen.dart';
import 'package:ags_flutter_starter/screens/emergency_screen.dart';
import 'package:ags_flutter_starter/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 35, 40),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo / Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 18, 84, 79).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.accessibility, size: 64, color: Color.fromARGB(255, 18, 84, 79)),
                ),
                const SizedBox(height: 24),

                // App Title
                const Text(
                  'BLS Companion',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 143, 140, 140),
                  ),
                ),
                const Text(
                  'your pocket guide to save lifes',
                  style: TextStyle(fontSize: 14, color: Color.fromARGB(179, 91, 91, 91)),
                ),
                const SizedBox(height: 40),

                // Name Input
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'insert your name',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
               
                 // Password Input
TextField(
  controller: _passwordController,
  obscureText: true,
  style: const TextStyle(color: Colors.white, fontSize: 16),
  decoration: InputDecoration(
    hintText: 'insert your password',
    hintStyle: const TextStyle(color: Colors.white54),
    prefixIcon: const Icon(
      Icons.lock_outline,
      color: Colors.white70,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white38),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
  ),
),
                const SizedBox(height: 16),

                // Log-in Button -> Navigates to MenuScreen
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 18, 84, 79),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
  final inputName = _nameController.text.trim();
  final inputPassword = _passwordController.text;

  if (inputName.isEmpty || inputPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter your name and password.'),
      ),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();

  final savedName = prefs.getString('user_name');
  final savedPassword = prefs.getString('user_password');
  final isRegistered = prefs.getBool('is_registered') ?? false;

  if (!isRegistered || savedName == null || savedPassword == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account not found. Please sign up first.'),
      ),
    );
    return;
  }

  if (inputName != savedName || inputPassword != savedPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect name or password.'),
      ),
    );
    return;
  }

  if (!context.mounted) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MenuScreen(userName: savedName),
    ),
  );
},
                    child: const Text(
                      'log-in',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                 
                 
                // Emergency Button -> Navigates to EmergencyScreen
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 102, 102, 0.98),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
  final name = _nameController.text.trim().isEmpty
      ? 'Siswa'
      : _nameController.text.trim();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EmergencyScreen(userName: name),
    ),
  );
},
                    child: const Text(
                      'EMERGENCY',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                 // Button 2: Sign Up (Week 7 Form Validation)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.person_add_alt_1),
                    onPressed: () {
                      // Navigator.push: Open registration form screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    label: const Text(
                      'Create New Account (Sign Up)', // [CHANGE HERE]: Button label
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
   void dispose() {
     _nameController.dispose();
    _passwordController.dispose();
     super.dispose();
    }
}