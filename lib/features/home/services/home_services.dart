import 'dart:convert';

import 'package:amazon_clone/constants/http_error_handle.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));

              print('Product List Fetched Successfully');
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print('Error while fetching product list');
    }

    return productList;
  }
}
