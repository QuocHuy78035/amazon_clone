import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});

  void navigateToCategory(BuildContext context, String category){
    Navigator.pushNamed(context, CategoryDealScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariable.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              navigateToCategory(context, "${GlobalVariable.categoryImages[index]['title']}");
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "${GlobalVariable.categoryImages[index]['image']}",
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  "${GlobalVariable.categoryImages[index]['title']}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
