import 'package:flutter/material.dart';
import 'package:papyrus/core/services/firestore_service.dart';
import 'package:papyrus/screens/widgets/custom_percentage_update.dart';
import 'package:papyrus/screens/widgets/custom_text_update.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: PopUpUpdate(),
        ),
      ),
    ),
  );
}

class PopUpUpdate extends StatefulWidget {
  const PopUpUpdate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopUpUpdateState createState() => _PopUpUpdateState();
}

class _PopUpUpdateState extends State<PopUpUpdate> {
  final _formKey = GlobalKey<FormState>();

  final FirestoreService firestoreService = FirestoreService();

  TextEditingController progressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(context) {
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
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              firestoreService.addComment(
                                              commentController.text,
                                              progressController.text as num);
                                            }
                                            commentController.clear();
                                            Navigator.pop(context);
                                          },
                                        )
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
                                            if (value == null || value.isEmpty) {
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
                                          }),
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
