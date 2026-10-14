import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ============================================================================
// SIGNUP SCREEN - KANTINKU STARTER TEMPLATE (Week 7: Form & Validation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// STUDENT GUIDE:
// This is the Sign Up / Registration Screen.
// Here you will learn 3 core Flutter Form concepts:
// 1. GlobalKey<FormState>: Master key to validate all input fields simultaneously.
// 2. TextEditingController: Bridge to capture and read user text input.
// 3. validator: Rule checker (e.g., non-empty, minimum 6 characters for password).
// ============================================================================

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // --------------------------------------------------------------------------
  // 1. FORM KEY & CONTROLLERS
  // --------------------------------------------------------------------------
  // _formKey acts as the validator lock before data is submitted
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to read text typed into each TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _countryCode = '+62';
  String _countryFlag = '🇮🇩';

  DateTime? _dateOfBirth;
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // State to toggle password visibility (hide/show characters)
  bool _obscurePassword = true;

  void _showDateOfBirthPicker() {
  DateTime selectedDate = _dateOfBirth ?? DateTime(2010, 1, 1);

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 201, 248, 244),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 360,
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Date of Birth',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                onDateChanged: (date) {
                  selectedDate = date;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _dateOfBirth = selectedDate;
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // [CHANGE HERE]: Background color
      appBar: AppBar(
        title: const Text(
          'Create BLS account', // [CHANGE HERE]: App bar title
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 23, 23), // [CHANGE HERE]: Main theme color
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // ------------------------------------------------------------------
            // 2. FORM WIDGET
            // Form wraps all TextFormFields so they can be validated together
            // ------------------------------------------------------------------
            child: Form(
              key: _formKey, // Attach form key here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header & Greeting
                  const Text(
                    'New Student Registration', // [CHANGE HERE]: Form title
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A5A61),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Fill out the form below to start ordering canteen food.', // [CHANGE HERE]: Subtitle
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),

                  // ============================================================
                  // INPUT 1: FULL NAME
                  // ============================================================
                  const Text(
                    'Full Name',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Alex Johnson', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.person_outline, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: Cannot be empty, min 3 characters
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                      if (value.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // null means VALID
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // INPUT 2: CLASS & STUDENT ID
                  // ============================================================
                  const Text(
                    'Class / Student ID', // [CHANGE HERE]: Can be 'Phone Number' or 'Table Number'
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 10-B (ID: 2026010)', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.school_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: Cannot be empty
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Class / Student ID is required';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // INPUT 3: PASSWORD
                  // ============================================================
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword, // Hides typed characters
                    decoration: InputDecoration(
                      hintText: 'Minimum 6 characters', // [CHANGE HERE]
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF0E7C86)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF64748B),
                        ),
                        onPressed: () {
                          // Toggle visibility on eye icon tap
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: Minimum 6 characters
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 18),

                  // ============================================================
                  // INPUT 4: CONFIRM PASSWORD
                  // ============================================================
                  const Text(
                    'Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: const InputDecoration(
                      hintText: 'Re-enter your password', // [CHANGE HERE]
                      prefixIcon: Icon(Icons.lock_reset_outlined, color: Color(0xFF0E7C86)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    // VALIDATOR: Must match initial password
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 18),
                  
                  

// Phone Number
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Country picker
    GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              _countryCode = '+${country.phoneCode}';
              _countryFlag = country.flagEmoji;
            });
          },
        );
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white38),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              _countryFlag,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 6),
            Text(
              _countryCode,
              style: const TextStyle(
                color:  Color(0xFF334155),
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color:  Color(0xFF334155),
            ),
          ],
        ),
      ),
    ),

    const SizedBox(width: 10),

    // Phone number
    Expanded(
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(
          color:  Color(0xFF334155),
        ),
        decoration: InputDecoration(
          hintText: 'Phone number',
          hintStyle: const TextStyle(
            color:  Color(0xFF334155),
          ),
          prefixIcon: const Icon(
            Icons.phone_outlined,
            color:  Color(0xFF334155),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color:  Color(0xFF334155),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color:  Color(0xFF334155),
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your phone number';
          }

          if (value.trim().length < 6) {
            return 'Enter a valid phone number';
          }

          return null;
        },
      ),
    ),
  ],
),
    const SizedBox(width: 16),

    

// Date of Birth
GestureDetector(
  onTap: () {
    _showDateOfBirthPicker();
  },
  child: Container(
    width: double.infinity,
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(97, 3, 74, 100)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.calendar_month_outlined,
          color:  Color(0xFF334155),
        ),
        const SizedBox(width: 12),
        Text(
          _dateOfBirth == null
              ? 'Date of birth'
              : '${_dateOfBirth!.day.toString().padLeft(2, '0')}/'
                '${_dateOfBirth!.month.toString().padLeft(2, '0')}/'
                '${_dateOfBirth!.year}',
          style: TextStyle(
            color: _dateOfBirth == null
                ? const Color(0xFF334155)
                : const Color(0xFF334155),
            fontSize: 16,
          ),
        ),
      ],
    ),
  ),
),
      const SizedBox(height: 16),
                  // ============================================================
                  // 3. SUBMIT BUTTON (SIGN UP NOW)
                  // ============================================================
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7C86), // [CHANGE HERE]: Button color
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () async {
  // Validate all fields
                        if (_formKey.currentState!.validate()) {
                       final userName = _nameController.text.trim();
                       final studentClass = _classController.text.trim();
                       final password = _passwordController.text;

    // Get local storage
    final prefs = await SharedPreferences.getInstance();

    // Save signup data
    await prefs.setString('user_name', userName);
    await prefs.setString('student_class', studentClass);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_registered', true);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully!'),
        backgroundColor: Color(0xFF0E7C86),
      ),
    );

    // Go back to Login Screen
    Navigator.pop(context);
                      }
                         },

                      child: const Text(
                        'Sign Up Now', // [CHANGE HERE]: Submit button text
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Back to Login Button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Pop back to LoginScreen
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Already have an account? Log in here',
                        style: TextStyle(
                          color: Color.fromARGB(255, 165, 231, 237),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // DISPOSE CONTROLLERS (Prevents device memory leaks)
  // --------------------------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
