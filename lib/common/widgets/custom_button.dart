import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  const CustomButton({super.key, required this.text, required this.onTap, this.color, this.borderColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(text,
        maxLines: 1,
        style: TextStyle(
          color: textColor == null ? (color == null ? Colors.white : Colors.black) : textColor
        ),),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          primary: color,
          side: BorderSide(
            width: 2,
            color: borderColor == null ? Colors.transparent : Colors.cyan
          )
        ),
    );
  }
}
