import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

void displayAddBookClub(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => const AlertDialog(
        title: Text("Create a new Book Club"),
        content: Stack(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            )
          ],
        )),
  );
}
