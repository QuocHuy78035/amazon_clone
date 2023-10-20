import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<String> imageUrl = [
    "https://plus.unsplash.com/premium_photo-1680985551009-05107cd2752c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
    "https://plus.unsplash.com/premium_photo-1680985551009-05107cd2752c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
    "https://plus.unsplash.com/premium_photo-1680985551009-05107cd2752c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
    "https://plus.unsplash.com/premium_photo-1680985551009-05107cd2752c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Your Orders',
                style: TextStyle(
                    color: GlobalVariable.unselectedNavBarColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: Text(
                'See all',
                style: TextStyle(
                    color: GlobalVariable.selectedNavBarColor,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrl.length,
              itemBuilder: (context, index){
            return SingleProduct(imageUrl: imageUrl[index]);
          }),
        )
      ],
    );
  }
}
