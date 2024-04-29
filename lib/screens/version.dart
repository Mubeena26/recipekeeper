import 'package:flutter/material.dart';

class VersionNumber extends StatelessWidget {
  const VersionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Version Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Version',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1.0.0', // Replace with your actual version number
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
