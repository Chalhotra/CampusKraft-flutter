import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType textInputType;
  final bool isPass;
  final TextEditingController textEditingController;
  final String hint;

  const CustomTextField({
    super.key,
    required this.textInputType,
    this.isPass = false,
    required this.textEditingController,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
          width: 0,
          color: Colors.black,
          strokeAlign: BorderSide.strokeAlignCenter,
          style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );
    return TextField(
      cursorColor: Colors.black,
      controller: textEditingController,
      keyboardType: textInputType,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
        border: border,
        // enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextInputType textInputType;
  final bool isPass;
  final TextEditingController textEditingController;
  final String hint;

  const PasswordField({
    super.key,
    required this.textInputType,
    this.isPass = false,
    required this.textEditingController,
    required this.hint,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  int seePass = 0;
  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
          width: 0,
          color: Colors.black,
          strokeAlign: BorderSide.strokeAlignCenter,
          style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );
    return TextField(
      cursorColor: Colors.black,
      controller: widget.textEditingController,
      keyboardType: widget.textInputType,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      obscureText: (seePass % 2 == 0) ? true : false,
      decoration: InputDecoration(
        suffix: IconButton(
          icon: (seePass % 2 == 0)
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              seePass++;
            });
          },
        ),
        hintText: widget.hint,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
        border: border,
        // enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
