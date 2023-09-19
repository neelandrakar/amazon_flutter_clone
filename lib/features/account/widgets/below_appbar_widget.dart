
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class BelowAppBarWidget extends StatelessWidget {
  const BelowAppBarWidget({super.key});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context,listen: false).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariable.appBarGradient
      ),
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                text: 'Hello, ',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black
                ),
                children: [
                  TextSpan(
                  text: user!='' ? user.name : 'Neel',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'
                  ),
                  ),
                ]
              ),
          ),
        ],
      ),
    );
  }
}
