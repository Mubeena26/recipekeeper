import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
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
                'These Terms and Conditions govern your use of the Recipe Project mobile application. By accessing or using the app, you agree to be bound by these terms and conditions.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '2. Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your use of the app is also subject to our Privacy Policy, which outlines how we collect, use, and disclose your personal information.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '3. Intellectual Property Rights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The content and materials provided in this app are protected by copyright and other intellectual property laws.',
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
