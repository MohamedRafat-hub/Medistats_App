import 'package:flutter/material.dart';
import 'package:medistats/core/helper_functions/get_initials.dart';

/// Displays a circular avatar with the first letters of the
/// patient's first and last name instead of a profile photo.
class InitialsAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  const InitialsAvatar({
    super.key,
    this.size = 56,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF2F6F5E),
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        getInitials(name),
        style: TextStyle(
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
