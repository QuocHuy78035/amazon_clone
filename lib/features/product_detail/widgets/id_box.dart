import 'package:flutter/material.dart';

class IdBox extends StatelessWidget {
  final String id;
  const IdBox({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Text(id);
  }
}
