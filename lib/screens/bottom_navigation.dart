// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:recipe_project/screens/cart_page.dart';

import 'package:recipe_project/screens/favourites.dart';
import 'package:recipe_project/screens/home.dart';
import 'package:recipe_project/screens/meal_planner.dart';
import 'package:recipe_project/screens/settings.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    const HomeScreen(),
    FavouriteScreen(),
    const CartPage(),
    const AddMealplanner(),
    const Settings()
    // Add other screens here for each tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 10, 105, 13),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white),
            label: 'Favorites',
            backgroundColor: Color.fromARGB(255, 10, 105, 13),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            label: 'Calendar',
            backgroundColor: Color.fromARGB(255, 10, 105, 13),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: 'Settings',
            backgroundColor: Color.fromARGB(255, 10, 105, 13),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
