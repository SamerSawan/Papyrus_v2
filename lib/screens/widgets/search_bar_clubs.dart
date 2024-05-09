import 'package:flutter/cupertino.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController searchController;
  final String hintText;
  final void Function(String) onChanged;

  const SearchTextField(
      {super.key,
      required this.searchController,
      required this.hintText,
      required this.onChanged});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    super.initState();
    // Initialize textController with the provided searchController's text
    textController = widget.searchController;
  }

  late TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoSearchTextField(
          controller: textController,
          placeholder: widget.hintText,
          onChanged: widget.onChanged,
          prefixIcon: const Icon(CupertinoIcons.search),
          itemColor: const Color.fromARGB(121, 245, 245, 221),
          style: const TextStyle(color: Color(0xFFF5F5DD)),
        ),
      ),
    );
  }
}
