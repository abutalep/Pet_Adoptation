import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/home");
        break;
      case 1:
        context.go("/search");
        break;
      case 2:
        context.go("/report");
        break;
      case 3:
        context.go("/adopt");
        break;
      case 4:
        context.go("/donation");
        break;
      default:
        context.go("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey.shade500,
      type: BottomNavigationBarType.fixed,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: "Report",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Adopt"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Donate"),
      ],
    );
  }
}
