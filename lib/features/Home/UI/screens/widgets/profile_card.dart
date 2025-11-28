import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //     const ProfileScreen(),
        //   ),
        // );
      },
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

          leading: Icon(Icons.person, size: 50, color: Color(0xFF44174E)),
          title: Text("welcome to HopePaw", style: TextStyle(fontSize: 15)),
          subtitle: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF44174E)),
        ),
      ),
    );
  }
}
