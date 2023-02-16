import 'package:flutter/material.dart';
class EditText extends StatefulWidget {
 EditText(this.controller,this.label,this.icon); TextEditingController controller;
 IconData icon;
 String label;
  @override
  State<EditText> createState() => _EditTextState(this.controller,this.label,this.icon);
}

class _EditTextState extends State<EditText> {
  @override
  TextEditingController controller;
  IconData icon;
  String label;
  _EditTextState(this.controller,this.label,this.icon);
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icon),
        border:OutlineInputBorder(borderSide: BorderSide(width: 1)),
      ),
    );
  }
}
