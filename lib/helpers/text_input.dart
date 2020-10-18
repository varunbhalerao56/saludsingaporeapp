import 'package:flutter/material.dart';

class text_input extends StatelessWidget {
  const text_input({
    Key key,
    @required TextEditingController TextController, this.labelText, this.hintText, this.message, this.lines,
  }) : _TextController = TextController, super(key: key);

  final TextEditingController _TextController;
  final String labelText;
  final String hintText;
  final String message;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:lines ,
      controller: _TextController,
      decoration: InputDecoration(
          hintText: hintText, labelText: labelText),
      validator: (value) =>
      value.isEmpty ? message : null,
    );
  }
}