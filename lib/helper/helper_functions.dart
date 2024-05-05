import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

void displayCreateBookClubBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
        title: Text("Create New Book Club"),
        content: Stack(children: [
          //custom text dialog
        ])),
  );
}
