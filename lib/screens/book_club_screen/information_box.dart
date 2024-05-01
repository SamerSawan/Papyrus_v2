import 'package:flutter/material.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({super.key});

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(left: 3.5, right: 0),
      width: 180,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0x8053917E)),
      child: const Center(
        child: Text('Information',
            style: TextStyle(
              color: Color.fromARGB(255, 245, 245, 221),
              fontFamily: 'Inter',
              fontSize: 12,
            )),
      ),
    );
  }
}
