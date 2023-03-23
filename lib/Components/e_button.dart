import 'package:flutter/material.dart';

class EButton extends StatefulWidget {
  late String title;
  late Function onPress;
  EButton(this.title, this.onPress, {super.key});

  @override
  State<EButton> createState() => _EButtonState();
}

class _EButtonState extends State<EButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPress(),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffeeb51d)),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title.toString(),
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: "open sans"),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
