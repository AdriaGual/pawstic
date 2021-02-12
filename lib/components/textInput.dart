import 'package:flutter/material.dart';
import 'package:pawstic/api/user_api.dart';
import "package:pawstic/globals.dart" as globals;

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final bool readOnly;
  TextInput(this.controller, this.text, this.obscureText, this.readOnly);

  @override
  State<StatefulWidget> createState() => TextInputState(
      this.controller, this.text, this.obscureText, this.readOnly);
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
  bool obscureText;
  bool readOnly;
  TextInputState(this.controller, this.text, this.obscureText, this.readOnly);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      cursorColor: globals.primaryColor,
      obscureText: this.obscureText,
      readOnly: !editingProfile && this.readOnly,
      style: TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 17.0,
          color: !editingProfile && this.readOnly
              ? globals.greyColor
              : globals.titleColor),
      decoration: InputDecoration(
          hintText: this.text,
          contentPadding: EdgeInsets.all(20.0),
          hintStyle: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 17.0,
              color: !editingProfile ? globals.greyColor : globals.titleColor),
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
    );
  }
}
