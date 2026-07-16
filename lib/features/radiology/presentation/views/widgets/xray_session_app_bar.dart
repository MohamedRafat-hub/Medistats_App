import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

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
    final initial = patientName.trim().isNotEmpty
        ? patientName.trim()[0].toUpperCase()
        : '?';

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      leadingWidth: 44,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
        color: const Color(0xFF1E293B),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryColor.withOpacity(0.12),
            child: Text(
              initial,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  patientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              color: const Color(0xFF475569),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}