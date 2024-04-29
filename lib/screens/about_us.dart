import 'package:flutter/material.dart';

class AboutUsScreeen extends StatelessWidget {
  const AboutUsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Recipe Project!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our mission is to make cooking fun and easy for everyone. With Recipe Project, you can discover delicious recipes, plan your meals, and create shopping lists with just a few taps.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Browse a vast collection of recipes for every occasion.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- Save your favorite recipes for quick access.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- Plan your meals for the week and generate shopping lists.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or feedback, feel free to reach out to us at support@recipeproject.com.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Recipe keeper:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1.0.0.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
