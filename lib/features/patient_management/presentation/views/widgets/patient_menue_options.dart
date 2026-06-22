import 'package:flutter/material.dart';

class CustomPatientMenuOption extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final void Function()? onPressed;

  const CustomPatientMenuOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(onPressed: onPressed, icon: Icon(icon) ,color: iconColor,
            iconSize: 18,
          ),
          // child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}