import 'package:flutter/material.dart';

class ELabel extends StatelessWidget {
  late String _label;

  ELabel(this._label, {super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: height * 0.005),
      child: Text(
        _label,
        style: const TextStyle(
            color: Color(0xffeeb51d),
            fontFamily: "open sans",
            fontWeight: FontWeight.w700,
            fontSize: 17),
      ),
    );
  }
}
