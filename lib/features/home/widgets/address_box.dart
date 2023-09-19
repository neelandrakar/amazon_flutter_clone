import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    String username = user != null ? user.name : 'Admin';

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(225, 114, 226, 221),
          Color.fromARGB(225, 162, 236, 233),
        ], stops: [
          0.5,
          1.0
        ]),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${username} - ${user.address}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2, right: 2),
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
