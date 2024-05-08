import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/screens/widgets/comment.dart';
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
          const Column(
            children: [
              CommentBox(),
            ],
          )     
        ],)
    );
  }
  
}