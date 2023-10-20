import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SingleSearchProduct extends StatefulWidget {
  final String imageUrl;
  final String name;
  final double price;
  final Product product;

  const SingleSearchProduct({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.product,
  });

  @override
  State<SingleSearchProduct> createState() => _SingleSearchProductState();
}

class _SingleSearchProductState extends State<SingleSearchProduct> {
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.ratings![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleProduct(imageUrl: widget.imageUrl),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Stars(rating: avgRating),
            Text(
              '\$${widget.price}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Eligible to FREE shipping',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Text(
              'In Stock',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal),
            ),
          ],
        )
      ],
    );
  }
}
