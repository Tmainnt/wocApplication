import "package:flutter/material.dart";

class BottomNavbar extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const BottomNavbar({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      items: [BottomNavigationBarItem(icon: Icon(Icons.chat))],
    );
  }
}
