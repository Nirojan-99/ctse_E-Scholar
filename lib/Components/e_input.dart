import 'package:flutter/material.dart';

class ETextField extends StatefulWidget {
  bool secure = false;
  String errorText = "";
  String? controller = "";
  ETextField(
      {this.secure = false, this.errorText = "", this.controller, super.key});

  @override
  State<ETextField> createState() => _ETextFieldState();
}

class _ETextFieldState extends State<ETextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.secure,
      style: const TextStyle(
          color: Colors.white,
          fontFamily: "open sans",
          fontWeight: FontWeight.w700,
          fontSize: 16),
      controller: _controller,
      cursorColor: Colors.white,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          errorText: !widget.errorText.isEmpty ? widget.errorText : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide.none),
          fillColor: const Color(0xff4b576f),
          filled: true),
    );
  }
}
