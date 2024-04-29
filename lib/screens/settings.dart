import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            onTap: () {
              Navigator.pushNamed(context, '/terms_conditions');
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator.pushNamed(context, '/privacy_policy');
            },
          ),
          // ListTile(
          //   title: Text('Version Number: 1.0.0'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/version no');
          //     // No action for version number
          //   },
          // ),
        ],
      ),
    );
  }
}
