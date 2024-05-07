import 'package:flutter/material.dart';

class CustomPercentageUpdate extends StatelessWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  const CustomPercentageUpdate(
      {super.key,
      required this.label,
      required this.validator,
      required this.controller});

  @override
  Widget build(context) {
    return SizedBox(
      width: 55,
      height: 25,
      child: Row(children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,
            expands: true,
            controller: controller,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            cursorHeight: 20,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                contentPadding: const EdgeInsets.all(1),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide.none),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                    borderSide: BorderSide.none),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: label),
          ),
        ),
      ]),
    );
  }
}
