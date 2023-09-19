import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class AppBarAdmin extends StatelessWidget {
  const AppBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariable.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            const Text('Admin',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),)
          ],
        ),
      ),
    );
  }

}
