import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          color: Colors.white,
          fontFamily: "open sans",
          fontWeight: FontWeight.w700,
          fontSize: 16),
      controller: _controller,
      cursorColor: Colors.white,
      maxLines: 1,
      
      decoration: InputDecoration(
        hintText: "search...",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
          fillColor: const Color(0xff4b576f),
          filled: true),
    );
    ;
  }
}
