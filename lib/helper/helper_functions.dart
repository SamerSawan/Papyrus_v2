import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/api/test.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/custom_text_input.dart';

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

void displayInviteUser(BuildContext context, String bookClubID) {
  TextEditingController usernameController = TextEditingController();
  FirestoreService firestoreService = FirestoreService();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(11)),
      backgroundColor: const Color.fromARGB(255, 210, 241, 228),
      content: Stack(
        children: [
          SizedBox(
            height: 150,
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        firestoreService.inviteUser(
                            username: usernameController.text,
                            bookClubId: bookClubID);
                      },
                      child: const Text('Confirm',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Enter username",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                CustomTextInput(
                  controller: usernameController,
                  label: '',
                  validator: (String? value) {},
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
