import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget widget;

  const CustomActionButton({
    super.key,
    required this.onPressed, required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2C7A8C),
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: widget,
      ),
    );
  }
}