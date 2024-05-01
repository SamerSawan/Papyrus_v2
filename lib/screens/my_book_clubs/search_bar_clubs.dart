import 'package:flutter/cupertino.dart';

void main() => runApp(const SearchTextField());

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController textController;

  @override
  void dispose() {
    textController.dispose();
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
            style: const TextStyle( color: Color(0xFFF5F5DD)),
          ),
      ),
    );
  }
}