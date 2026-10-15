import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ags_flutter_starter/screens/emergency_detail_screen.dart';

class EmergencyScreen extends StatefulWidget {
  final String userName;

  const EmergencyScreen({super.key, required this.userName});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  static const Color darkBackground = Color(0xFF091F2A);
  static const Color medicalRed = Color(0xFFE53935);
  static const Color softRed = Color(0xFFFF6B6B);

  Timer? _countdownTimer;
  int _countdown = 0;
  bool _isCountingDown = false;

  void _startCountdown() {
    if (_isCountingDown) return;

    setState(() {
      _isCountingDown = true;
      _countdown = 1;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_countdown < 3) {
        setState(() => _countdown++);
      } else {
        timer.cancel();
        setState(() => _isCountingDown = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmergencyDetailScreen(userName: widget.userName),
          ),
        );
      }
    });
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    if (!mounted) return;
    setState(() {
      _isCountingDown = false;
      _countdown = 0;
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -75,
              right: -65,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: medicalRed.withValues(alpha: 0.13),
                ),
              ),
            ),
            Positioned(
              bottom: -95,
              left: -65,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: softRed.withValues(alpha: 0.08),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: medicalRed.withValues(alpha: 0.15),
                          border: Border.all(
                            color: softRed.withValues(alpha: 0.45),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.health_and_safety_rounded,
                          size: 62,
                          color: softRed,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'EMERGENCY\nASSISTANCE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          height: 1.08,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We’re here to help, ${widget.userName}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFFB8B8),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Choose the assistance option to continue to the first-response guide. Stay calm and check that the area is safe.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD0DCE2),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 28),
                      if (_isCountingDown) ...[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 118,
                          height: 118,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: medicalRed.withValues(alpha: 0.18),
                            border: Border.all(color: softRed, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: medicalRed.withValues(alpha: 0.2),
                                blurRadius: 24,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$_countdown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 54,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Preparing your guide…',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextButton.icon(
                          onPressed: _cancelCountdown,
                          icon: const Icon(Icons.close_rounded),
                          label: const Text('Cancel'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton.icon(
                            onPressed: _startCountdown,
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: const Text(
                              'GET EMERGENCY GUIDANCE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: medicalRed,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: medicalRed.withValues(alpha: 0.35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.10),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFFFFB8B8),
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'This button opens the app’s guidance page; it does not contact emergency services. If someone is in immediate danger, contact local emergency services now.',
                                style: TextStyle(
                                  color: Color(0xFFD0DCE2),
                                  fontSize: 11,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
