import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLightMode = false; // Toggle for light/dark mode

  // Example user data
  final String username = "johndoe";
  final String firstName = "John";
  final String lastName = "Doe";
  final String email = "johndoe@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightMode ? Colors.white : const Color(0xFF282828),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: isLightMode ? const Color(0xFFF0F0F0) : const Color(0xFF121212),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlue.withOpacity(0.6),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Profile',
                style: TextStyle(
                  fontSize: 26,
                  color: isLightMode ? const Color(0xFF4A90E2) : const Color(0xFFADD8E6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildUserInfoRow('Username', username),
              _buildUserInfoRow('First Name', firstName),
              _buildUserInfoRow('Last Name', lastName),
              _buildUserInfoRow('Email', email),
              const SizedBox(height: 20),
              _buildActionButton('Logout', () {
                // Add logout logic here
              }),
              _buildActionButton('Back', () {
                // Add navigation logic here
              }),
              _buildActionButton('Home', () {
                // Add redirection logic here
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLightMode = !isLightMode;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLightMode ? const Color(0xFF4A90E2) : const Color(0xFFADD8E6),
                  foregroundColor: Colors.black,
                ),
                child: Text(isLightMode ? 'Switch to Dark Mode' : 'Switch to Light Mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16,
              color: isLightMode ? const Color(0xFF333333) : Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isLightMode ? const Color(0xFF333333) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLightMode ? const Color(0xFF4A90E2) : const Color(0xFFADD8E6),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(text),
    );
  }
}
