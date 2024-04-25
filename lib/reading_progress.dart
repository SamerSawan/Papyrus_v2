import 'package:flutter/material.dart';

class ReadingProgress extends StatelessWidget {
  const ReadingProgress({super.key});
  
  @override
  Widget build(context) {
     return const Center(
          child: LinearProgressIndicator(),
        );
  }
}
