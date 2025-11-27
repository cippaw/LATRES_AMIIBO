import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int index = 0;

  final favService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(favService: favService),
      FavoriteScreen(favService: favService),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
