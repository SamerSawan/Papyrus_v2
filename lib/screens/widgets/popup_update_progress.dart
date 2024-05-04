import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papyrus/screens/widgets/custom_text_update.dart';

class TestPop extends StatefulWidget {
  const TestPop({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TestPopState createState() => _TestPopState();
}

class _TestPopState extends State<TestPop> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
  return Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor:MaterialStatePropertyAll(Color(0xFFD2F1E4))),
            onPressed: () async {
              await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(10),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(11)),
                    backgroundColor:const Color.fromARGB(255, 210, 241, 228),
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: [Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                TextButton(
                                  onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                ),
                              ),
                              TextButton(
                                      child: const Text('Submit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    )]
                              ),
                              const Text('Check in with your reading progress.', 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              )),
                              Form(
                              key: _formKey,
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.all(20),
                                    child: CustomTextUpdate(label: 'Add a comment...'),
                                  ),
                                ],
                              ),
                            ),
                              ]
                          ),
                          ],
                        ),
                      ));
            },
            child: const Text('Update Progress',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.bold
            )),
          ),
        );
}
}