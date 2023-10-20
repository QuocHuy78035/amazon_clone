import 'dart:convert';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/err_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class ProductDetailService {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        body: jsonEncode({'id': product.id, 'rating': rating}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        body: jsonEncode({
          'id': product.id,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      httpErrHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
