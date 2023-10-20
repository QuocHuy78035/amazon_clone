import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/loading.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_detail/screens/detail_product_screen.dart';
import 'package:amazon_clone/features/search/services/search_service.dart';
import 'package:amazon_clone/features/search/widgets/single_search_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String? searchQuery;

  const SearchScreen({super.key, this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? productList;

  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
  }

  void fetchSearchProducts() async {
    productList = await searchServices.fetchSearchProducts(
        context: context, query: "${widget.searchQuery}");
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToDetailProductScreen(Product product) {
    Navigator.pushNamed(context, DetailProductScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
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
      body: productList == null
          ? const Loading()
          : Column(
              children: [
                const AddressBox(),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList?.length,
                    itemBuilder: (context, index) {
                      String newImageUrl = productList![index]
                          .images[0]
                          .replaceAll('[', '')
                          .replaceAll(']', '');
                      return GestureDetector(
                        onTap: (){
                          navigateToDetailProductScreen(productList![index]);
                        },
                        child: SingleSearchProduct(
                          product: productList![index],
                          imageUrl: newImageUrl,
                          name: productList![index].name,
                          price: productList![index].price,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
