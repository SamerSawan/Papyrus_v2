import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

class BottomNavBarCopy extends StatefulWidget {
  const BottomNavBarCopy({super.key});

  @override
  State<BottomNavBarCopy> createState() => _BottomNavBarCopyState();
}
final scakey = GlobalKey<_BottomNavBarCopyState>();

class _BottomNavBarCopyState extends State<BottomNavBarCopy> {


final myKey = GlobalKey<_BottomNavBarCopyState>();
int _selectedIndex = 0;
final CupertinoTabController _controller = CupertinoTabController();

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.index = index;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return CupertinoTabScaffold(
      controller: _controller,
      key: myKey,
      tabBar: CupertinoTabBar(
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(209, 0, 26, 35).withOpacity(0.85),
        border: const Border(top: BorderSide(color: Color(0xFFD2F1E4), width: 1)
            ),
        iconSize: 25,
        activeColor: const Color(0xFFD2F1E4),
        inactiveColor: const Color.fromARGB(255, 125, 125, 125),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore)
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.local_library)
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person)
          )
        ],
      ),
      tabBuilder: (context, int index) { switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('Home'),
                  ),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('BookShelves'),
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('Discover'),
                  ),
                );
              },
            );
            case 3:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: MyBookClubs(),
                  ),
                );
              },
            );
            case 4:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('Profile'),
                  ),
                );
              },
            );
            default:
            return const CupertinoTabView();
      } 
      },
    );
  }
}