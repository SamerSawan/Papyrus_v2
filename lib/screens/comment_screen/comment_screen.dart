import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
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
    return const Scaffold(
      body: Text('Comments')
    );
  }
  
}