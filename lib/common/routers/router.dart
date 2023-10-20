import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/product_detail/screens/detail_product_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

MaterialPageRoute generateRouter(RouteSettings routerSetting) {
  switch (routerSetting.name) {
    case AuthScreen.routerName:
      return MaterialPageRoute(
          settings: routerSetting, builder: (_) => const AuthScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routerSetting, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routerSetting, builder: (_) => const AddProductScreen());
    case CategoryDealScreen.routeName:
      var category = routerSetting.arguments as String;
      return MaterialPageRoute(
          settings: routerSetting,
          builder: (_) => CategoryDealScreen(category: category));
    case SearchScreen.routeName:
      var searchQuery = routerSetting.arguments as String;
      return MaterialPageRoute(
          settings: routerSetting,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case DetailProductScreen.routeName:
      var product = routerSetting.arguments as Product;
      return MaterialPageRoute(
          settings: routerSetting,
          builder: (_) => DetailProductScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      var totalAmount = routerSetting.arguments as String;
      return MaterialPageRoute(
        settings: routerSetting,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routerSetting,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exit'),
          ),
        ),
      );
  }
}
