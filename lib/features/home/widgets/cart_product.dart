import 'package:amazon_clone/features/cart/services/cart_service.dart';
import 'package:amazon_clone/features/product_detail/services/product_detail_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../accounts/widgets/single_product.dart';

class CartProduct extends StatefulWidget {
  final int index;

  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    final ProductDetailService productDetailService = ProductDetailService();
    final CartService cartService = CartService();

    void increaseQuantityProduct(Product product){
      productDetailService.addToCart(context: context, product: product);
    }

    void decreaseQuantityProduct(Product product){
      cartService.removeFromCart(context: context, product: product);
    }
    return Row(
      children: [
        SingleProduct(imageUrl: product.images[0]),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            //Stars(rating: avgRating),
            Text(
              '\$${product.price}',
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
                color: Colors.teal,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => decreaseQuantityProduct(product),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text('$quantity'),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () => increaseQuantityProduct(product),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
