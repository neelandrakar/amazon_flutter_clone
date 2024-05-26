import 'package:amazon_clone/features/account/screen/my_orders_screen.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(buttonText: 'Your Order', onTap: (){
              Navigator.pushNamed(context, MyOrdersScreen.routeName);
            }),
            AccountButton(buttonText: 'Turn Seller', onTap: (){}),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountButton(buttonText: 'Log Out', onTap: (){}),
            AccountButton(buttonText: 'Your Wishlist', onTap: (){}),
          ],
        )
      ],
    );
  }
}
