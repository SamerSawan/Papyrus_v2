import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  final String description;
  const DescriptionBox({super.key, required this.description});

  @override
  Widget build(context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0.67),
      child: Container(
        width: 367,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 0, right: 3.5),
                width: 180,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0x8053917E)),
                child: Center(
                  child: Text(description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 221),
                        fontFamily: 'Inter',
                        fontSize: 12,
                      )),
                )),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
