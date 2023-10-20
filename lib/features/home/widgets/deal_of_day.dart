import 'package:amazon_clone/features/admin/screens/loading.dart';
import 'package:amazon_clone/features/home/sevices/home_service.dart';
import 'package:amazon_clone/features/product_detail/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealsOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loading()
        : Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: const Text(
                  'Deal of the day',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: product);
                },
                child: Image.network(product!.images[0]),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '\$1000',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Quoc Huy',
                  style: TextStyle(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                    product!.images.map(
                      (e) => Image.network(
                        e,
                        width: 150,
                        height: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ).toList(),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('See all deals'),
              )
            ],
          );
  }
}
