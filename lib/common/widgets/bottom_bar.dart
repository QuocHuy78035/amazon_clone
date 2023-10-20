import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/bottom_nav_provider.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../features/accounts/screens/account_screen.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final double bottomBarWidth = 42;
  final double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    print(Provider.of<UserProvider>(context).user.type);
    return Consumer<BottomNavProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: pages[value.indexPage],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              value.setIndex(index);
            },
            currentIndex: value.indexPage,
            selectedItemColor: GlobalVariable.selectedNavBarColor,
            unselectedItemColor: GlobalVariable.unselectedNavBarColor,
            iconSize: 28,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: value.indexPage == 0
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth),
                      ),
                    ),
                    child: const Icon(Icons.home_outlined),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: value.indexPage == 1
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth),
                      ),
                    ),
                    child: const Icon(Icons.person_outline),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: value.indexPage == 2
                              ? GlobalVariable.selectedNavBarColor
                              : GlobalVariable.backgroundColor,
                          width: bottomBarBorderWidth),
                    ),
                  ),
                  child: badges.Badge(
                    badgeContent: Text('$userCartLength'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
