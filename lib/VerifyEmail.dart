import 'package:flutter/material.dart';
import 'OTP_Verification.dart';
void main() {
  runApp(const MaterialApp(
    home: VerifyEmailPage (),
    debugShowCheckedModeBanner: false,
  ));
}

class VerifyEmailPage  extends StatelessWidget {
  const VerifyEmailPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E002A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Arrow
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 60),

              // Phone Icon
              Center(
                child: Icon(
                  Icons.smartphone,
                  size: 100,
                  color: Colors.purpleAccent,
                ),
              ),

              const SizedBox(height: 30),

              // Verification Text
              const Center(
                child: Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'We will send you a One Time Password\non your Email Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Email TextField
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: InputBorder.none,
                ),
              ),

              const SizedBox(height: 30),

              // Get OTP Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OTPVerificationPage()),
                    );
                  },

                  child: const Text(
                    'GET OTP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
