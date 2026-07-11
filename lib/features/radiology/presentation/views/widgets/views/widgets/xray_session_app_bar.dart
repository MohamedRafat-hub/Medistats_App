import 'package:flutter/material.dart';

class XraySessionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const XraySessionAppBar({
    super.key,
    required this.patientName,
    required this.subtitle,
  });

  final String patientName;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: const BackButton(color: Colors.black87),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            patientName,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(Icons.more_vert, color: Colors.black87),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
