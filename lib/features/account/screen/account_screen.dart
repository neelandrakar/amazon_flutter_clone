import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/widgets/below_appbar_widget.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      body: Column(
        children: [
            BelowAppBarWidget(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Orders()
        ],
      ),
    );
  }

  PreferredSize appBarMethod() {
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
            Container(
              // color: Colors.red,
              padding: EdgeInsets.only(left: 15,right: 15),
              child: const Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined,
                  color: Colors.black,),
                  ),
                  Icon(Icons.search,
                    color: Colors.black,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
