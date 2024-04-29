import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

@override
Widget build(context){
return Container(
  child:  const GNav(
    backgroundColor: Color.fromARGB(209, 0, 26, 35),
    iconSize: 25,
    activeColor: Color(0xFFD2F1E4),
    tabBorder: Border(top: BorderSide(color: Color(0xFFD2F1E4), width: 1)),
    tabs: [
    GButton(icon: Icons.home, text: 'Home'),
    GButton(icon: Icons.auto_stories_outlined, text: 'BookShelf'),
    GButton(icon: Icons.explore, text: 'Discover'),
    GButton(icon: Icons.local_library_outlined, text: 'BookClub'),
    GButton(icon: Icons.person, text: 'Profile')
  ])
);
}

}