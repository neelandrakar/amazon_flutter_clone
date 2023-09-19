import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white
        ),
        child: OutlinedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.black12.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            )
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal
            ),),
        ),
      ),
    );
  }
}
