import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  void _checkPalindrome() {
    final sentence = _sentenceController.text;
    final cleaned = sentence.replaceAll(' ', '').toLowerCase();
    final reversed = cleaned.split('').reversed.join();
    final isPalindrome = cleaned == reversed;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Result'),
        content: Text(isPalindrome ? 'isPalindrome' : 'not palindrome'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _goToSecondScreen() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SecondScreen(userName: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_first.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar Icon
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/ic_photo.png'),
                  ),
                  const SizedBox(height: 50),

                  // Input Name
                  _buildInput(_nameController, 'Name'),

                  const SizedBox(height: 20),

                  // Input Palindrome
                  _buildInput(_sentenceController, 'Palindrome'),

                  const SizedBox(height: 45),

                  // CHECK Button
                  _buildButton('CHECK', _checkPalindrome),

                  const SizedBox(height: 20),

                  // NEXT Button
                  _buildButton('NEXT', _goToSecondScreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B637B), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
