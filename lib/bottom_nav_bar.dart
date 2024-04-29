import 'package:flutter/material.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
final PageController _pageController = PageController();
final List<Widget> _screens = const [
  MyBookClubs(),
  //const Icon(Icons.home),
  //const Icon(Icons.book_online),
  //const Icon(Icons.compass_calibration),
 // const Icon(Icons.person)
  ];

int _currentIndex = 0;
    void _onPageChanged (int index) {
    setState(() {
      _currentIndex = index;
    });
    }

    void _onItemTapped (int currentIndex) {
      _pageController. jumpToPage (currentIndex) ;
    }

  @override
  Widget build(context){
    return Scaffold(
      body: PageView(
        controller : _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
        ),
      bottomNavigationBar: 
      Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFD2F1E4), width: 1)
            )
            ),
      child: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(209, 0, 26, 35),
        iconSize: 25,
        selectedItemColor: const Color(0xFFD2F1E4),
        unselectedItemColor: const Color.fromARGB(255, 125, 125, 125),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
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
      body: BottomNavBar()
      )
    ),
  );
}