import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final int? maxLine;
  final TextEditingController textEditingController;
  const CustomTextField({super.key, required this.textEditingController, this.hintText, this.maxLine});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val){
        if(val == null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLine,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: "$hintText",
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
