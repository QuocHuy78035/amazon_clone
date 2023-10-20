import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String imageUrl;

  const SingleProduct({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 180,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl
                ),
                //fit: BoxFit.fitHeight
              )
            ),
          )
        ),
      ),
    );
  }
}
