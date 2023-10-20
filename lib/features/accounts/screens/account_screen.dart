import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/accounts/widgets/top_button.dart';
import 'package:flutter/material.dart';
import '../widgets/bellow_app_bar.dart';
import '../widgets/orders.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
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
                      Icon(Icons.notifications_none_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search_outlined),
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
      body: const Column(
        children: [
          BellowAppBar(),
          SizedBox(
            height: 20,
          ),
          TopButton(),
          Orders()
        ],
      ),
    );
  }
}
