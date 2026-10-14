
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
  static const Color red = Color(0xFFC62828);
  static const Color darkRed = Color(0xFF8E1717);
  static const Color paleRed = Color(0xFFFFF1F1);
  static const Color ink = Color(0xFF252B36);
  static const Color muted = Color(0xFF777F8D);

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9A9FAB),
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: red, size: 21),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFFFFBFB),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFF0D9D9),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFF0D9D9),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: red,
          width: 1.7,
        ),
      ),
    );
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    final inputName = _nameController.text.trim();
    final inputPassword = _passwordController.text;

    if (inputName.isEmpty || inputPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name and password.'),
          backgroundColor: darkRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      final savedName = prefs.getString('user_name');
      final savedPassword = prefs.getString('user_password');
      final isRegistered =
          prefs.getBool('is_registered') ?? false;

      if (!mounted) return;

      if (!isRegistered ||
          savedName == null ||
          savedPassword == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account not found. Please sign up first.',
            ),
            backgroundColor: darkRed,
          ),
        );
        return;
      }

      if (inputName != savedName ||
          inputPassword != savedPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect name or password.'),
            backgroundColor: darkRed,
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuScreen(
            userName: savedName,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
          backgroundColor: darkRed,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openEmergency() {
    final name = _nameController.text.trim().isEmpty
        ? 'Siswa'
        : _nameController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmergencyScreen(
          userName: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 460,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Medical branding
                  Center(
                    child: Container(
                      width: 94,
                      height: 94,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [darkRed, red, Color(0xFFE65353)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(29),
                        boxShadow: [
                          BoxShadow(
                            color: red.withOpacity(0.22),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.medical_services_rounded,
                        size: 49,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'BLS Companion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                      color: darkRed,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your pocket guide to first response',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: muted,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Login card
                  Container(
                    padding: const EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFFF4E1E1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkRed.withOpacity(0.055),
                          blurRadius: 25,
                          offset: const Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: ink,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Log in to continue your journey.',
                          style: TextStyle(
                            color: muted,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                          'Full name',
                          style: TextStyle(
                            color: ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 9),

                        TextField(
                          controller: _nameController,
                          textCapitalization:
                              TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'Enter your registered name',
                            icon: Icons.person_outline_rounded,
                          ),
                        ),

                        const SizedBox(height: 19),

                        const Text(
                          'Password',
                          style: TextStyle(
                            color: ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 9),

                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _login(),
                          decoration: _inputDecoration(
                            hint: 'Enter your password',
                            icon: Icons.lock_outline_rounded,
                            suffix: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: muted,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: red,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                                  const Color(0xFFE9A3A3),
                              elevation: 2,
                              shadowColor:
                                  red.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth: 2.3,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.login_rounded,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'LOG IN',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                              FontWeight.w800,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 19),

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFEFE3E3),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'NEW HERE?',
                                style: TextStyle(
                                  color: muted.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFEFE3E3),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 13),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.person_add_alt_1_rounded,
                              size: 19,
                            ),
                            label: const Text(
                              'Create New Account',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: red,
                              side: const BorderSide(
                                color: Color(0xFFE7B7B7),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Emergency access remains prominent
                  SizedBox(
                    height: 59,
                    child: ElevatedButton(
                      onPressed: _openEmergency,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE6E6),
                        foregroundColor: darkRed,
                        elevation: 0,
                        side: const BorderSide(
                          color: Color(0xFFF3B9B9),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emergency_rounded,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EMERGENCY',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Open emergency assistance',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.health_and_safety_outlined,
                        color: Color(0xFFB9A1A1),
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Learn first response. Be ready to help.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: muted,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
