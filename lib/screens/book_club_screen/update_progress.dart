import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class UpdateBox extends StatelessWidget {
  const UpdateBox({super.key});

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      width: 130,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: const Color(0xFFD2F1E4)),
      child: const Center(
        child: Text('Update Progress',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.bold
            )),
      ),
    );
  }
}