import 'package:flutter/cupertino.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController searchBarController = TextEditingController();

    @override
  void initState() {
    super.initState();
    searchBarController = TextEditingController(text: 'Search');
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
          child: CupertinoSearchTextField(
            decoration: BoxDecoration(
                      color: const Color.fromARGB(51, 217, 217, 217),
                      borderRadius: BorderRadius.circular(20),
            ),
            placeholder: 'Search',
            prefixIcon : const Icon(CupertinoIcons.search),
            itemColor: const Color.fromARGB(121, 245, 245, 221),
            style: const TextStyle( color: Color(0xFFF5F5DD)),
          ),
      ),
    );
  }
}