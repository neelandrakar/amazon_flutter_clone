import 'dart:convert';

import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/http_error_handle.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  sellProducts(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      print('part 1');

      final cloudinary = CloudinaryPublic('dhfiapa0x', 'giscyuqg');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);


      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      print('Json req ' + product.toJson());
      print('Json res ' + res.body + '${res.statusCode}');
      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product added successfully!");
            Navigator.pop(context);
          });
      print('part 5');
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  //Get all the products

  Future<List<Product>> fetchAllTheProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
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
      print('Error while fetcing product list');
    }

    return productList;
  }

  //Delete a product

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackBar(context, 'Product has been deleted successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  void deleteProduct_({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
