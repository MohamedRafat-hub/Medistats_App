import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int maxLines;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.maxLines  =1,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this Field is required';
        }
        return null;
      },
      onSaved: onSaved,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff7E7E7E),
          fontSize: 16,
        ),
        fillColor: const Color(0xffE9EBF0),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}