import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();

  int _selectedIndex = 0;
  final CupertinoTabController _controller = CupertinoTabController();
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
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        border:
            const Border(top: BorderSide(color: Color(0xFFD2F1E4), width: 1)),
        iconSize: 25,
        activeColor: Theme.of(context).colorScheme.secondary,
        inactiveColor: Theme.of(context).colorScheme.tertiary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories)),
          BottomNavigationBarItem(icon: Icon(Icons.explore)),
          BottomNavigationBarItem(icon: Icon(Icons.local_library)),
          BottomNavigationBarItem(icon: Icon(Icons.person))
        ],
        onTap: (index) {
          if (_selectedIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 2:
                thirdTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 3:
                fourthTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
            }
          }
          _selectedIndex = index;
        },
      ),
      tabBuilder: (context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: firstTabNavKey,
              builder: (BuildContext context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('Home'),
                  ),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: secondTabNavKey,
              builder: (BuildContext context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('BookShelves'),
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: thirdTabNavKey,
              builder: (BuildContext context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Text('Discover'),
                  ),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              navigatorKey: fourthTabNavKey,
              builder: (BuildContext context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: MyBookClubs(),
                  ),
                );
              },
            );
          case 4:
            return CupertinoTabView(
              navigatorKey: fifthTabNavKey,
              builder: (BuildContext context) {
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
