import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_detail/services/product_detail_service.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/features/product_detail/widgets/id_box.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variable.dart';
import '../../../models/product.dart';
import '../widgets/name_box.dart';

class DetailProductScreen extends StatefulWidget {
  static const String routeName = '/detail-product';
  final Product product;

  const DetailProductScreen({super.key, required this.product});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ProductDetailService productDetailService = ProductDetailService();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState(){
    super.initState();
    double totalRating = 0;
    for (int i = 0 ; i < widget.product.ratings!.length; i++){
      totalRating += widget.product.ratings![i].rating;
      if(widget.product.ratings![i].userId == Provider.of<UserProvider>(context, listen: false).user.id){
        myRating = widget.product.ratings![i].rating;
      }
    }
    if(totalRating != 0){
      avgRating = totalRating/ widget.product.ratings!.length;
    }
  }

  void addToCart(){
    productDetailService.addToCart(context: context, product: widget.product);
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    String newImageUrl =
        widget.product.images[0].replaceAll('[', '').replaceAll(']', '');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.search_outlined),
                          ),
                          filled: true,
                          fillColor: GlobalVariable.backgroundColor,
                          contentPadding: const EdgeInsets.only(top: 10),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                height: 42,
                child: const Icon(Icons.mic),
              )
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IdBox(id: "${widget.product.id}"),
              Stars(
                rating: avgRating,
              ),
            ],
          ),
          NameBox(name: widget.product.name),
          Image.network(
            newImageUrl,
            fit: BoxFit.fill,
          ),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          RichText(
            text: TextSpan(
              text: 'Deal Price: ',
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: "\$${widget.product.price}",
                    style: const TextStyle(color: Colors.red))
              ],
            ),
          ),
          Text(widget.product.description),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(onPressed: () {}, label: "Buy now"),
          const SizedBox(
            height: 30,
          ),
          CustomButton(onPressed: () {
            addToCart();
            Navigator.pop(context);
          }, label: "Add to cart"),
          const SizedBox(
            height: 30,
          ),
          const Text('Rate The Products'),
          RatingBar.builder(
            minRating: 1,
            initialRating: myRating,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemBuilder: (context, _) {
              return const Icon(
                Icons.star,
                color: GlobalVariable.secondaryColor,
              );
            },
            onRatingUpdate: (rating) {
              setState(() {
                productDetailService.rateProduct(context: context, product: widget.product, rating: rating);
              });
            },
          )
        ],
      ),
    );
  }
}
