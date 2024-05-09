import 'package:flutter/material.dart';

class CustomTextUpdate extends StatelessWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final double height;

  const CustomTextUpdate({
    super.key,
    required this.label,
    required this.validator,
    required this.controller,
    required this.height,
  });

  @override
  Widget build(context) {
    return SizedBox(
      width: 330,
      height: height,
      child: Row(children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,
            expands: true,
            controller: controller,
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            cursorHeight: 20,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.black26,
              contentPadding: const EdgeInsets.all(5),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: 11,
                  color: const Color.fromARGB(255, 0, 0, 0)
                      .withOpacity(0.5)), // Placeholder text
            ),
          ),
        ),
      ]),
    );
  }
}
