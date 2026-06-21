import 'package:flutter/material.dart';

/// Displays a circular avatar with the first letters of the
/// patient's first and last name instead of a profile photo.
class InitialsAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  const InitialsAvatar({
    super.key,
    required this.firstName,
    required this.lastName,
    this.size = 56,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF2F6F5E),
  });

  String get _initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
