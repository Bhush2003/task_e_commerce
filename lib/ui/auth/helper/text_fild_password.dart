import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget errorText;

  const TextFieldPassword({super.key, required this.controller,required this.validator, required this.errorText});

  @override
  State<TextFieldPassword> createState() => _TextFildPasswordState();
}

class _TextFildPasswordState extends State<TextFieldPassword> {

  bool isVisible=false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isVisible,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: (){
          setState(() {
            isVisible=!isVisible;
          });
        }, icon:isVisible?Icon(Icons.visibility):Icon(Icons.visibility_off) ),
        hint: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
