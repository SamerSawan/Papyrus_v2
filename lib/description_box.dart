import 'package:flutter/material.dart';


class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key});

  @override
  Widget build(context) {
    return Center(
    child:  Column (children: [
    const Text("Book club description"),
    Positioned(
      top: 251,
      left: 20,
      right: null,
      bottom: null, 
      child: Container(
   decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)),
   height: 100,
   width: 100,
 )) ],)
);
}
}