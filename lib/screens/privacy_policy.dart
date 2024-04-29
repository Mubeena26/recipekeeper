import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This Privacy Policy explains how we collect, use, and disclose your personal information when you use our mobile application.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '2. Information Collection and Use',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We may collect certain personal information, including but not limited to...',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '3. Information Sharing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We may share your personal information with third parties...',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
