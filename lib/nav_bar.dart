import 'package:flutter/material.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBar();
}


class _NavigationBar extends State<NavigationBar> {
int _currentIndex=0;
List<Widget> body = const [
  Icon(Icons.home),
  Icon(Icons.book_online),
  Icon(Icons.compass_calibration),
  BookClubScreen(),
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
backgroundColor: Color(0x80001A23),
            label: 'Home',
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0x80001A23),
            label: 'Books',
            icon: Icon(Icons.auto_stories)
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0x80001A23),
            label: 'Discover',
            icon: Icon(Icons.explore)
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0x80001A23),
            label: 'Club',
            icon: Icon(Icons.local_library)
            ),
          BottomNavigationBarItem(
            backgroundColor: Color(0x80001A23),
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
      body: NavigationBar()
      )
    ),
  );
}