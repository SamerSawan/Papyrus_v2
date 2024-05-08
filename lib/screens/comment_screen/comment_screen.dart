import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/theme/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      darkTheme: darkMode,
      home: const Scaffold(
        body: Center(
          child: CommentScreen(),
        ),
      ),
    ),
  );
}

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _CommmentScreenState();
}

class _CommmentScreenState extends State<CommentScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(
        children: [
          CupertinoNavigationBar(
            middle: Text('Comments',
              style: Theme.of(context).textTheme.titleMedium,),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()
                ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: 367,
                height: 116,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          radius: 15,
                          child: const Text('JC'),
                          ),
                        const SizedBox(width: 5),
                        const Text(
                          '[User] is [x] % through. ',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '[Comment]',
                        ),
                    const Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.chat_bubble_outline_rounded, // need to change icon i dont like this one lol
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          )     

        ],)
    );
  }
  
}