import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/address.dart';
import '../../../providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    String username = user != null ? user.name : 'Admin';
    dynamic addressList;



    // Check if the addresses list is not empty
    bool hasAddresses = user.addresses!.isNotEmpty;
    if(hasAddresses){

      final addresses = context.watch<UserProvider>().user.addresses![0];
      addressList = Address.fromMap(addresses['addressInfo']);
    }

    return Visibility(
      visible: hasAddresses, // Show the widget if addresses is not empty
      child: Container(
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
                  hasAddresses
                      ? 'Delivery to ${username} - ${addressList.flatNo}, ${addressList.area}, ${addressList.pincode}'
                      : 'No Address Available', // Handle case when addresses is empty
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
      ),
    );
  }
}
