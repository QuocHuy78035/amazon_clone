import 'dart:convert';

import 'package:provider/provider.dart';

import '../../../constants/err_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProducts({
    required BuildContext context,
    required String query
}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/products/search/$query'), headers: {
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
}