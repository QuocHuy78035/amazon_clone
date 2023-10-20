import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_clone/constants/err_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/models/user.dart';
import '../../../constants/utils.dart';
import 'package:provider/provider.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        cart: [],
        id: '',
        name: name,
        email: email,
        password: password,
        type: '',
        address: '',
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  Future<void> singInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences.setMockInitialValues({});
          SharedPreferences preferences = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          print(jsonDecode(res.body)['token']);
          await preferences.setString(
              'x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, 'error: ${e.toString()}');
    }
  }

  //get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('x-auth-token') ?? "";
      if(token == ""){
        preferences.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token' : token
        }
      );
      var response = jsonDecode(tokenRes.body);
      if(response == true){
        http.Response res = await http.get(
          Uri.parse('$uri/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          }
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(res.body);
      }

    } catch (e) {
      print('error: $e');
    }
  }
}
