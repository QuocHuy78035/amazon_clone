import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/loading.dart';
import 'package:amazon_clone/features/home/sevices/home_service.dart';
import 'package:amazon_clone/features/product_detail/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variable.dart';
import '../../../models/product.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState(){
    super.initState();
    fetchCategoryProducts();
  }

  void fetchCategoryProducts() async{
    productList = await homeServices.fetchCategoryProducts(context: context, category: widget.category);
    setState(() {});
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
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null ? const Loading() : Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Keep Shopping For ${widget.category}',
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList?.length,
              padding: const EdgeInsets.only(left: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.4
              ),
              itemBuilder: (context, index) {
                String newImageUrl = productList![index].images[0].replaceAll('[', '').replaceAll(']', '');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: productList?[index]);
                      },
                      child: SingleProduct(imageUrl: newImageUrl),
                    ),
                    Text(productList![index].name),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
