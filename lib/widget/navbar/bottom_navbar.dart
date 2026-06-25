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
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF7E8CFD),
      unselectedItemColor: Colors.black, 
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"), 
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      ],
    );
  }
}
