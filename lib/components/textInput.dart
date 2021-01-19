import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;

class TextInput extends StatefulWidget {
  TextEditingController controller;
  String text;
  TextInput(this.controller, this.text);

  @override
  State<StatefulWidget> createState() =>
      TextInputState(this.controller, this.text);
}

String validateField(String value) {
  if (value.isEmpty) {
    return "El campo no puede estar vacío";
  }
  return null;
}

class TextInputState extends State<TextInput> {
  TextEditingController controller;
  String text;
  TextInputState(this.controller, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        controller: this.controller,
        cursorColor: globals.primaryColor,
        style: TextStyle(
            fontFamily: 'PoppinsRegular',
            fontSize: 17.0,
            color: globals.titleColor),
        decoration: InputDecoration(
            hintText: this.text,
            contentPadding: EdgeInsets.all(20.0),
            hintStyle: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 17.0,
                color: globals.greyColor),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: const BorderRadius.all(
                const Radius.circular(15.0),
              ),
            ),
            filled: true,
            fillColor: globals.fillGreyColor),
      ),
    );
  }
}
