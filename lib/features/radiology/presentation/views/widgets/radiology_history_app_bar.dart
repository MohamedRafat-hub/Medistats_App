import 'package:flutter/material.dart';

class RadiologyHistoryAppBar extends StatelessWidget {
  const RadiologyHistoryAppBar({super.key, required this.patientName});

  final String patientName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
        color: const Color(0xFF1E293B),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      centerTitle: true,
      titleSpacing: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Radiology History',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            patientName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}