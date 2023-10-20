import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/err_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class HomeServices{
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });
      httpErrHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
    return products;
  }



  Future<Product> fetchDealsOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    Product products = Product(name: '', description: '', quantity: 0, images: [], category: '', price: 0);
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });
      httpErrHandle(
        response: res,
        context: context,
        onSuccess: () {
          products = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
    return products;
  }
}