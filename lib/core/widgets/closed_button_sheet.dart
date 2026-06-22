import 'package:flutter/material.dart';

Widget buildCloseButton(BuildContext context , void Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Color(0xffE5E5E5),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.close, size: 18, color: Color(0xff5A5A5A)),
    ),
  );
}