import 'package:amazon_clone/features/admin/screens/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variable.dart';
import '../../../providers/bottom_nav_provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  final double bottomBarWidth = 42;
  final double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostScreen(),
    AnalyticsScreen(),
    const Center(child: Text('Cart Page'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariable.appBarGradient
                ),
              ),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/amazon_in.png', height: 45,color: Colors.black,),
                      const Row(
                        children: [
                          Text('Admin', style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
          ),
        ),
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
                  child: const Icon(Icons.analytics),
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
                  child: const Icon(Icons.card_travel_sharp)),
              label: '',
            ),
          ],
        ),
      );
    });
  }
}
