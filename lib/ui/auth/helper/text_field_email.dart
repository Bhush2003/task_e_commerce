import 'package:flutter/material.dart';

class TextFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget errorText;

  const TextFieldEmail({super.key,required this.controller,required  this.validator,required  this.errorText});

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hint: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
