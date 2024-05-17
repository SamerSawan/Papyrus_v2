import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/screens/widgets/custom_percentage_update.dart';
import 'package:papyrus/screens/widgets/custom_text_update.dart';

class PopUpUpdate extends StatefulWidget {
  final String bookClubID;
  final VoidCallback onProgressUpdated; // Add this line

  const PopUpUpdate(
      {super.key,
      required this.bookClubID,
      required this.onProgressUpdated}); // Modify constructor

  @override
  _PopUpUpdateState createState() => _PopUpUpdateState();
}

class _PopUpUpdateState extends State<PopUpUpdate> {
  final _formKey = GlobalKey<FormState>();

  final FirestoreService firestoreService = FirestoreService();

  TextEditingController progressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  String username = ''; // Declare username as non-nullable

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Call fetchUsername when the widget is initialized
  }

  Future<void> fetchUsername() async {
    try {
      // Fetch the username
      username = await firestoreService.fetchUsername() ??
          ''; // Set a default value if null
      setState(() {}); // Update the UI after fetching username
    } catch (e) {
      // Handle error
      print('Error fetching username: $e');
    }
  }

  @override
  Widget build(context) {
    // Show loading indicator if username is null
    if (username == null) {
      return CircularProgressIndicator(); // Replace with your loading indicator
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xFFD2F1E4))),
        onPressed: () async {
          await showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(11)),
                    backgroundColor: const Color.fromARGB(255, 210, 241, 228),
                    content: Form(
                      key: _formKey,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: 215,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            progressController.clear();
                                            commentController.clear();
                                          },
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                        ),
                                        TextButton(
                                            child: const Text('Submit',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                )),
                                            onPressed: () async {
                                              // Check if username is null
                                              String? username =
                                                  await firestoreService
                                                      .fetchUsername();
                                              if (username != null) {
                                                firestoreService.updateProgress(
                                                    widget.bookClubID,
                                                    username,
                                                    int.parse(progressController
                                                        .text));
                                              } else {
                                                // Handle case where username is null
                                                print('Username is null');
                                              }

                                              firestoreService.updateProgress(
                                                  widget.bookClubID,
                                                  username!,
                                                  int.parse(
                                                      progressController.text));
                                              commentController.clear();
                                              progressController.clear();
                                              Navigator.pop(context);
                                              widget
                                                  .onProgressUpdated(); // Call the callback
                                            })
                                      ]),
                                  const Text(
                                      'Check in with your reading progress.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text('I\'m ',
                                          style: TextStyle(
                                            color: Color.fromARGB(194, 0, 0, 0),
                                            fontSize: 13,
                                          )),
                                      CustomPercentageUpdate(
                                          label: '',
                                          controller: progressController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please update your progress';
                                            }
                                            return null;
                                          }),
                                      const Text(
                                          ' % done.', //through instead of done ??
                                          style: TextStyle(
                                            color: Color.fromARGB(194, 0, 0, 0),
                                            fontSize: 13,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text('What do you think so far?',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Color.fromARGB(194, 0, 0, 0),
                                          fontSize: 13,
                                        )),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CustomTextUpdate(
                                          label: 'Add a comment...',
                                          controller: commentController,
                                          validator: (value) {
                                            return null;
                                          },
                                          height: 75),
                                    ],
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ));
        },
        child: const Text('Update Progress',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
