import 'package:flutter/material.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}


class _NavBar extends State<NavBar> {
int _currentIndex=0;
List<Widget> body = const [
  MyBookClubs(),
  Icon(Icons.home),
  Icon(Icons.book_online),
  Icon(Icons.compass_calibration),
  Icon(Icons.person)
];
  @override
  Widget build(context){
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
        ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFD2F1E4), width: 1)
            )
            ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(209, 0, 26, 35),
        iconSize: 25,
        selectedItemColor: const Color(0xFFD2F1E4),
        unselectedItemColor: const Color.fromARGB(255, 125, 125, 125),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Books',
            icon: Icon(Icons.auto_stories)
          ),
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Icon(Icons.explore)
            ),
            BottomNavigationBarItem(
            label: 'Club',
            icon: Icon(Icons.local_library)
            ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person)
          )
        ],
      )
    ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: const Scaffold(
      body: NavBar()
      )
    ),
  );
}