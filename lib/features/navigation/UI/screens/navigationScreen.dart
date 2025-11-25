import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hopepaw/features/Home/UI/screens/homescreen.dart';
import 'package:hopepaw/features/report/UI/screens/report_screen.dart';



class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  static const String routename = "navigation screen";

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
} 

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    Center(child: Text("Search", style: TextStyle(fontSize: 22))),
    ReportScreen(),
    Center(child: Text("Adopt", style: TextStyle(fontSize: 22))),
    Center(child: Text("Donation", style: TextStyle(fontSize: 22))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          
          backgroundColor: Color(0xFFD0BAC7),
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xFF44174E),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items:  [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 30,
                height: 35,
                color: currentIndex == 0 ? Color(0xFF44174E) : Colors.white
              ),
              label: "Home",
              
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 30,
                height: 35,
                color: currentIndex == 1 ? Color(0xFF44174E) : Colors.white
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/plus.svg',
                width: 30,
                height: 35,
                color: currentIndex == 2 ? Color(0xFF44174E) : Colors.white
              ),
              label: "Report",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/pawprint.svg',
                width: 30,
                height: 35,
                color: currentIndex == 3 ? Color(0xFF44174E) : Colors.white
              ),
              label: "Adopt",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/money.svg',
                width: 30,
                height: 35,
                color: currentIndex == 4 ? Color(0xFF44174E) : Colors.white
              ),
              label: "Donation",
            ),
          ],
        ),
      ),
    );
  }
}



