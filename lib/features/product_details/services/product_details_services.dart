import 'dart:convert';

import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/http_error_handle.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices {


  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      try{

        http.Response res = await http.post(
          Uri.parse('$uri/api/rate-product'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': userProvider.user.token,
            },
            body: jsonEncode({
              'id': product.id,
              'rating': rating
            }),
        );

        HttpErrorHandle(
            response: res,
            context: context,
            onSuccess: (){
              showSnackBar(context, 'Product rated successfully');
            });


      } catch (e) {
        print("Error $e");
        showSnackBar(context, e.toString());
      }

  }
}
